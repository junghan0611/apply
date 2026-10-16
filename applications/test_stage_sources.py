#!/usr/bin/env python3
"""Archived AX source lookup must not lose legacy artifact paths or stage any files."""
import unittest
import stage


class ArchivedSourceTests(unittest.TestCase):
	def test_competency_source_is_archived(self):
		pdf = stage.ROOT / "dossier/build/KimJunghan_AX_Competency.pdf"
		expected = stage.ROOT / "docs/samples/dossier/competency.org"
		self.assertEqual(stage.source_org(pdf), [expected])
		self.assertTrue(expected.is_file())

	def test_portfolio_source_is_archived(self):
		pdf = stage.ROOT / "dossier/build/KimJunghan_AX_Portfolio.pdf"
		expected = stage.ROOT / "docs/samples/dossier/portfolio.org"
		self.assertEqual(stage.source_org(pdf), [expected])
		self.assertTrue(expected.is_file())

	def test_recorded_legacy_artifact_path_is_not_rewritten(self):
		text = "| 추가 첨부 | `dossier/build/KimJunghan_AX_Portfolio.pdf` |"
		self.assertEqual(stage.cuts_of(text), [stage.ROOT / "dossier/build/KimJunghan_AX_Portfolio.pdf"])

	def test_english_resume_mapping_is_unchanged(self):
		pdf = stage.ROOT / "resume/build/KimJunghan_Resume_Embedded_Software_Engineer.pdf"
		self.assertEqual(stage.source_org(pdf), [
			stage.ROOT / "resume/body.org",
			stage.ROOT / "resume/targets/embedded-software-engineer.org",
		])

	def test_generated_source_note_does_not_reactivate_sample(self):
		case = stage.ROOT / "applications/example--systems"
		text = stage.sources_doc(case, ["KimJunghan_AX_Portfolio.pdf"])
		self.assertIn("docs/samples/dossier/README.md", text)
		self.assertNotIn("(cd dossier", text)
		self.assertNotIn("이미 tracked", text)
		self.assertIn("applications/stage.py example--systems", text)

	def test_systems_portfolio_is_not_an_archived_ax_output(self):
		case = stage.ROOT / "applications/example--systems"
		text = stage.sources_doc(case, ["KimJunghan_Systems_BSP_Portfolio.pdf"])
		self.assertNotIn("# 과거 AX 입력:", text)


if __name__ == "__main__":
	unittest.main()
