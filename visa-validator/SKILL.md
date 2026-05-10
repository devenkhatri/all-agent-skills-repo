---
name: visa-validator
description: Use when someone asks to scan visa documents, validate against country checklists, perform gap analysis, and generate approval probability scores.
---
## Purpose
Scan a folder of visa documents, validate against country checklist,
produce gap analysis and approval probability score.

## Steps
1. List all files in the target folder
2. Read and extract text from each document via OCR
3. Load checklist from /checklists/{country}.json
4. PII Scrubbing Layer eg. Strip raw passport numbers before sending to LLM — send structure only
5. Compare docs vs checklist
6. Generate structured report with Gaps + Probability Score + Key Insights
7. Save report to folder as visa-review-report-{Current Date and Time}.md

## Process
1. **Input Collection**: Ask user for the folder path containing visa documents and the target country
2. **File Discovery**: List all files in the specified folder
3. **Document Processing**: For each document:
   - Extract text using OCR (try multiple methods: macOS Vision, EasyOCR, Tesseract)
   - Apply PII scrubbing to remove sensitive data like passport numbers, SSNs, etc.
   - Structure the extracted data for comparison
4. **Checklist Loading**: Load the appropriate country checklist from /checklists/{country}.json
5. **Validation & Gap Analysis**: Compare document contents against checklist requirements
6. **Scoring**: Calculate approval probability based on completeness and accuracy
7. **Report Generation**: Create a detailed markdown report with:
   - Identified gaps
   - Approval probability score (0-100%)
   - Key insights and recommendations
8. **Output**: Save report as visa-review-report-{timestamp}.md in the same folder

## Inputs
- Folder path containing visa documents
- Target country (for checklist selection)

## Outputs
- Markdown report file: visa-review-report-{timestamp}.md

## Dependencies
- OCR tools (macOS Vision, EasyOCR, Tesseract)
- JSON checklist files in /checklists/ directory
- Basic text processing utilities

## Guardrails
- PII scrubbing must be applied before any LLM processing
- Handle missing checklists gracefully
- Support common document formats (PDF, JPG, PNG, etc.)
- Provide clear error messages for unsupported formats