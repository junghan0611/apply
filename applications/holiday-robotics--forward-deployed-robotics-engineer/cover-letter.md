# Cover Letter — Holiday Robotics / Forward Deployed Robotics Engineer

**폼의 `Cover Letter` 는 파일이 아니라 textarea 다** (2026-07-29 브라우저 실측).
아래 「붙여넣을 본문」을 **그대로 복사해 붙인다.** 서식이 없으므로 굵게·목록을 쓰지 않았다.

- 언어: **영문.** 채용 사이트·공고·폼이 전부 영문이고 붙일 이력서도 영문 컷이다.
- 길이: 약 385 단어. 회사 원칙이 **Radical Simplicity** 다 — 길게 쓰는 것 자체가 어긋난다.
- ROS2 문단이 이 글의 심장이다. `submission.md` §ROS2 에서 정한 화법을 그대로 폈다.

---

## 붙여넣을 본문

I build systems that have to keep working after I leave the room. That is what drew me to this role.

At GoQual, I shipped a Zigbee/Wi-Fi smart home hub to mass production: Zig firmware, a deterministic state machine across driver, protocol, and cloud boundaries, and 24-hour aging-test automation. The contract covered firmware; it did not cover the server or companion app. I built those too, in Go and Flutter, because a firmware deliverable is not a product until a customer can install it, operate it, and recover it. I later moved the hub core from ARMv7/glibc to RISC-V on statically linked musl and extracted a board HAL so the core no longer knows which board it runs on. I also delivered a Matter wallpad as a versioned Android SDK inside a customer's namespace — their build, their release train, their constraints.

That last part is the job you are describing: enter someone else's environment, make the system stable there, and bring the field findings back so the product changes. Your Field-First principle — usefulness is proven on the factory floor, not in a demo — is the sentence I would have written for those aging tests.

On the stack, I work with Linux, Python, and Docker. Board-level hardware and network debugging have been part of my work since my first startup's embedded product line; the current RF stack includes Zigbee, Thread, and Matter on EFR32MG24, ESP32-H2, RK3576, and Raspberry Pi 5 with a Hailo-8 NPU.

On ROS2, I would rather be exact than generous. I worked with it in graduate school, but I have not owned production ROS2 deployments. What I can claim is that I have assembled embedded stacks from bootloader through kernel, drivers, protocols, and cloud, and taken them to mass production. In that context, ROS2 is a layer I have not had to use deeply yet, not a wall. For a field-deployment role, I know how to become effective at the layer that the system and the customer require.

I hold a valid driver's license and am available for business travel.

My work is public and dated: github.com/junghan0611 and notes.junghanacs.com. The same pattern runs through it: build the interface, leave evidence behind, and make hand-offs inspectable by someone other than the author.

I would like to help put FRIDAY on a real floor.

---

## 왜 이렇게 썼는가 — 나중에 되물릴 때를 위해

1. **첫 줄이 자기소개가 아니다.** "keep working after I leave the room" 은 FDE 직무의 정의
   자체이고, 동시에 GLG 가 현직에서 계속 받는 요청("나에게 의존하지 않고 돌아가게 해 달라")과
   같은 문장이다.
2. **계약 밖의 일을 했다는 것을 사실로만 적었다.** 공치사 없이 "펌웨어는 계약이었고 서버·앱은
   아니었다"로 두면 읽는 쪽이 알아서 판단한다.
3. **고객사 네임스페이스 SDK 딜리버리를 문단 끝에 놓았다.** 이 회사가 뽑는 자리가 정확히
   그것이라 다음 문단이 "That last part is the job you are describing" 으로 받는다.
4. **ROS2 는 변명하지 않고 경계를 먼저 긋는다.** "generous" 대신 "exact" 를 고르겠다고 말하고,
   못 하는 것을 말한 뒤 할 수 있는 것을 댄다. 마지막 문장("If this role were about authoring
   ROS2 internals, I would tell you")은 **지원자가 직무를 읽었다는 증거**다.
5. **공개 증거는 한 줄로만 닫았다.** npm 설치 수·가든 규모는 이력서에 있다. 커버레터에서는
   공개 주소와 「남이 이어받아 검사할 수 있는 hand-off」 원칙만 남긴다.
6. **닫는 문장에 제품 이름(FRIDAY)을 쓴다.** 회사를 조사했다는 표시이면서 현장(floor)이라는
   이 회사의 언어를 되돌려준다.

## 🔴 교차검수에서 걷어낸 것 (2026-07-29, GPT)

초안에 **근거 없는 주장 셋**이 있었다. 전부 걷어냈다. 남기는 이유는 같은 실수를 반복하지 않기 위해서다.

| 걷어낸 문장 | 왜 |
|---|---|
| `Linux, Python, Docker, and **gRPC** are daily tools` | **`resume/body.org` 에 gRPC 근거가 없다.** 공고는 gRPC 를 「이해」 수준으로 요구하고 **필수로 못 박은 것은 ROS2 뿐**이다. 없는 것을 있다고 하지 않는다 — `FAQ.md` §원칙 1 |
| `board/RF ... where **most of the last decade** went` | RF 스택(Zigbee·Thread·Matter)은 **2025.09~** 다. 보드 레벨·임베디드는 NEMO-UX(2013–2017)부터 이어지지만 **RF 를 10년으로 부를 수 없다.** 둘을 갈라 적었다 |
| ~~`and am **available for business travel**`~~ | ✅ **되살렸다 (2026-07-29 11:20).** 당시엔 `FAQ.md` §4 가 ⚠ 미확정이라 걷어냈던 것이고, **GLG 가 「출장 가능」으로 확정**해 원래 자리로 돌아갔다. 걷어낸 판단 자체는 옳았다 — 순서가 「GLG 확정 → 문서」였다는 기록으로 남긴다 |

> ✅ **제출 전 확인 2개 중 하나가 닫혔다.** 공고 필수는 `Valid driver's license **and
> availability for business travel**` 인데, 면허·출장 **둘 다 GLG 확인 완료**(2026-07-29)이고
> `FAQ.md` §4 에 반영했다. **남은 하나는 gRPC** — 실경험이 있다면 `body.org` 에 먼저 넣고
> 나서 커버레터에 쓴다. 순서를 뒤집지 않는다.
