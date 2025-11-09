# SavoyConnect Timeline Generator

This tool generates professional project timeline visualizations for the SavoyConnect project.

## Requirements

Install the required Python packages:

```bash
pip install matplotlib pandas openpyxl numpy
```

## Usage

Run the script to generate all visualizations:

```bash
python generate_timeline.py
```

## Generated Files

The script will create 5 files:

1. **timeline_gantt_chart.png** - Complete Gantt chart showing all phases with dates
2. **resource_allocation.png** - Man-hours by phase and team composition
3. **phase_breakdown.png** - Detailed task breakdown for major phases
4. **project_summary.png** - Executive summary with key statistics
5. **savoyconnect_timeline.xlsx** - Detailed Excel report with all tasks

## Project Overview

- **Tech Stack**: MySQL + Laravel (Backend) + Flutter (Mobile) + Next.js (Web)
- **Total Duration**: ~22 weeks (5.5 months)
- **Total Man-Hours**: ~2,800 hours
- **Team Size**: 6-8 members
- **Phases**: 7 (Planning, Backend, Mobile, Web, Testing, Deployment, Support)

## Customization

Edit the `project_data` dictionary in `generate_timeline.py` to adjust:
- Task durations
- Team sizes
- Phase timelines
- Start dates

## Output Format

All charts are saved as high-resolution PNG files (300 DPI) suitable for presentations and documentation.
