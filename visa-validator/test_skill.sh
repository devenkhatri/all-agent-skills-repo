#!/bin/bash

# Test script for visa-validator skill

echo "Testing visa-validator skill..."
echo "Folder: /tmp/visa-test-documents"
echo "Country: USA"

# Step 1: List all files in the target folder
echo "Step 1: Listing files in /tmp/visa-test-documents"
ls -la /tmp/visa-test-documents/

# Step 2: Read and extract text from each document via OCR (simulated)
echo "Step 2: Extracting text from documents (simulated OCR)"
for file in /tmp/visa-test-documents/*; do
  echo "Processing $file"
  # Simulate OCR by reading the file content
  content=$(cat "$file")
  echo "Extracted content: $content"
  # Simulate PII scrubging: remove patterns that look like passport numbers, SSNs, etc.
  # For simplicity, we'll just note that we would scrub PII here
  echo "Applied PII scrubbing (simulated)"
done

# Step 3: Load checklist from /checklists/{country}.json
echo "Step 3: Loading checklist for USA"
checklist_file="/Users/devengoratela/.agents/skills/visa-validator/checklists/usa.json"
if [ -f "$checklist_file" ]; then
  echo "Checklist loaded successfully"
  cat "$checklist_file" | jq .  # Assuming jq is installed for pretty print
else
  echo "Checklist file not found: $checklist_file"
fi

# Step 4-6: Compare docs vs checklist, generate report, save report (simulated)
echo "Step 4-6: Comparing documents against checklist, generating report, and saving (simulated)"
# In a real implementation, we would do the comparison and scoring here.
# For the test, we'll just create a mock report.

report_file="/tmp/visa-test-documents/visa-review-report-$(date +'%Y%m%d-%H%M%S').md"
echo "Generating report: $report_file"

cat > "$report_file" << EOF
# Visa Review Report

**Generated:** $(date)
**Country:** USA
**Visa Type:** B1/B2 Tourist Visa

## Document Analysis

### Passport (passport.jpg)
- Status: Present
- Validation: Would check expiration date and blank pages (simulated)

### Bank Statement (bank_statement.pdf)
- Status: Present
- Validation: Would check for sufficient funds (simulated)

## Gap Analysis
- Missing DS-160 Confirmation
- Missing Photo
- Missing Appointment Confirmation
- Missing Travel Itinerary (optional)
- Missing Ties to Home Country documents

## Approval Probability Score: 30%

## Key Insights
1. Core documents (passport and financials) are present.
2. Critical application forms and biometric requirements are missing.
3. Strongly recommended to provide all required documents before submission.

## Recommendations
- Complete DS-160 online application and bring confirmation page.
- Obtain a compliant visa photograph.
- Schedule visa interview appointment.
- Provide additional evidence of ties to home country (employment letter, property documents, etc.).
EOF

echo "Report saved to: $report_file"
echo "Test completed."