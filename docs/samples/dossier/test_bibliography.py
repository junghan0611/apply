#!/usr/bin/env python3
"""dossier 서지 격리 회귀 검사 — 문서가 `#+bibliography:` 를 선언하면 개인 전역 서지가 끼어들지 않는다.

2026-10-15 실물 사고: 파이프라인이 Doom 설정의 개인 서지(`config-bibfiles`)를 전역으로 얹어,
같은 키가 개인 서지에도 있으면 저장소 references.bib 대신 그 항목이 렌더됐다(저자 누락, 없는 열람일).

임시 디렉터리에서 작은 Org 한 장을 latex-export.el 로 내보낸다. `ORG_DIRECTORY` 를 같은 키의
가짜 개인 서지가 든 임시 디렉터리로 바꿔 「다른 기계」를 흉내 낸다. 실파일·build/ 는 건드리지 않는다.
Emacs(Doom straight 코어)가 필요하다 — `./run.sh check` 가 통과하는 기계에서 돈다.

	./test_bibliography.py        # 실패하면 exit 1
"""
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
KEY = "shadowkey"
LOCAL = "LOCALTITLE" + "MARK"
PERSONAL = "PERSONALTITLE" + "MARK"

DOC = f"""#+title: bib isolation
#+bibliography: local.bib
#+cite_export: csl ieee.csl

* Body
Claim [cite:@{KEY}].

#+print_bibliography:
"""


def bib(title: str) -> str:
	return f"@misc{{{KEY},\n  author = {{Kim, Junghan}}, title = {{{title}}}, year = {{2026}}\n}}\n"


def export(td: Path, org_dir: Path) -> tuple[int, str, str]:
	env = dict(os.environ)
	env.setdefault("EMACSDIR", str(Path.home() / "doomemacs"))
	env.setdefault("DOOMDIR", str(Path.home() / "repos/gh/doomemacs-config"))
	env["ORG_DIRECTORY"] = str(org_dir) + "/"
	out = td / "out.tex"
	r = subprocess.run(
		["emacs", "-Q", "--batch", "--script", str(td / "pipeline" / "latex-export.el"),
		 str(td / "doc.org"), str(out)],
		cwd=td, env=env, capture_output=True, text=True, timeout=600,
	)
	return r.returncode, out.read_text() if out.exists() else "", r.stdout + r.stderr


def main():
	fails = []
	with tempfile.TemporaryDirectory() as tmp:
		td = Path(tmp)
		shutil.copytree(HERE / "pipeline", td / "pipeline")
		(td / "doc.org").write_text(DOC)
		(td / "local.bib").write_text(bib(LOCAL))
		# 같은 키를 쥔 가짜 개인 서지 — config-bibfiles 후보 경로 중 하나에 둔다.
		shadow = td / "org-shadow"
		(shadow / "resources" / "bib").mkdir(parents=True)
		(shadow / "resources" / "bib" / "Software.bib").write_text(bib(PERSONAL))
		empty = td / "org-empty"
		empty.mkdir()

		results = {}
		for name, org_dir in (("개인 서지 충돌 키", shadow), ("개인 서지 없음", empty)):
			code, tex, log = export(td, org_dir)
			results[name] = tex
			if code != 0 or not tex:
				fails.append(f"{name}: export 실패 exit {code}\n    {log.strip()[-400:]}")
				continue
			# CSL 이 제목을 title case 로 바꾸므로(LOCALX → Localx) 대소문자를 무시하고 본다.
			low = tex.lower()
			if LOCAL.lower() not in low:
				fails.append(f"{name}: 문서 서지 항목이 렌더되지 않음")
			if PERSONAL.lower() in low:
				fails.append(f"{name}: 개인 서지 항목이 문서 서지를 가렸다")

		# Org 가 실행마다 바꾸는 두 가지는 빼고 비교한다 — `% Created <시각>` 줄과 자동 라벨
		# (`sec:org4411d20` 처럼 실행마다 새로 뽑는 id).
		strip = lambda s: re.sub(r"\{(\w+):org[0-9a-f]+\}", r"{\1:org}",
		                         "\n".join(x for x in s.splitlines() if not x.startswith("% Created")))
		a, b = (strip(results.get(k, "")) for k in ("개인 서지 충돌 키", "개인 서지 없음"))
		if a and b and a != b:
			fails.append("두 환경의 .tex 가 다르다 — 개인 서지에 따라 문서가 바뀐다")

	n = 5
	if fails:
		print(f"FAIL {len(fails)}/{n}")
		for f in fails:
			print("  " + f)
		return 1
	print(f"ok {n}/{n} — 충돌 키 환경·빈 환경 모두 문서 서지만 렌더 · 두 환경 .tex 동일")
	return 0


if __name__ == "__main__":
	sys.exit(main())
