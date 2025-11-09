"""
SavoyConnect Project Timeline Visualization Generator
Generates professional charts and timelines for project planning
"""

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import Rectangle
import numpy as np
from datetime import datetime, timedelta
import pandas as pd

# Set style for professional look
plt.style.use('seaborn-v0_8-darkgrid')
colors = {
    'planning': '#6366F1',
    'backend': '#EC4899',
    'mobile': '#10B981',
    'web': '#F59E0B',
    'testing': '#8B5CF6',
    'deployment': '#EF4444',
    'support': '#14B8A6'
}

# Project data with realistic estimates
project_data = {
    'Phase 1: Planning & Design': {
        'duration_weeks': 2,
        'tasks': [
            ('Requirements Documentation', 40, 'PM + Team'),
            ('Database Schema Design', 60, '1 Backend Dev'),
            ('API Specifications', 50, '1 Backend Dev'),
            ('UI/UX Refinement', 80, '1 Designer'),
            ('Architecture Documentation', 40, '1 Backend Dev'),
            ('Sprint Planning', 20, 'PM')
        ],
        'color': colors['planning'],
        'team': ['Backend Dev (1)', 'Designer (1)', 'PM (1)']
    },
    'Phase 2: Backend Development': {
        'duration_weeks': 8,
        'tasks': [
            ('Database Setup & Migrations', 60, '1 Backend Dev'),
            ('Authentication System', 80, '1 Backend Dev'),
            ('User Management APIs', 60, '1 Backend Dev'),
            ('Product Catalog APIs', 80, '1 Backend Dev'),
            ('Order Management System', 120, '2 Backend Devs'),
            ('Payment Gateway Integration', 100, '1 Backend Dev'),
            ('Delivery Management', 80, '1 Backend Dev'),
            ('Admin Panel APIs', 100, '1 Backend Dev'),
            ('Loyalty Points Engine', 60, '1 Backend Dev'),
            ('Notification Service', 40, '1 Backend Dev')
        ],
        'color': colors['backend'],
        'team': ['Backend Dev (2)', 'DevOps (0.5)']
    },
    'Phase 3: Mobile App Development': {
        'duration_weeks': 10,
        'tasks': [
            ('Flutter Project Setup', 40, '1 Mobile Dev'),
            ('Authentication Screens', 60, '1 Mobile Dev'),
            ('Home Feed & Navigation', 80, '1 Mobile Dev'),
            ('Product Browse & Search', 100, '1 Mobile Dev'),
            ('Custom Box Builder', 120, '2 Mobile Devs'),
            ('Shopping Cart & Checkout', 80, '1 Mobile Dev'),
            ('Payment Integration', 80, '1 Mobile Dev'),
            ('Order Tracking UI', 60, '1 Mobile Dev'),
            ('Profile & Wallet', 60, '1 Mobile Dev'),
            ('Loyalty Rewards UI', 60, '1 Mobile Dev'),
            ('Push Notifications', 40, '1 Mobile Dev'),
            ('Recipe Sharing Features', 80, '1 Mobile Dev')
        ],
        'color': colors['mobile'],
        'team': ['Mobile Dev (2)', 'Designer (0.5)']
    },
    'Phase 4: Web Development': {
        'duration_weeks': 8,
        'tasks': [
            ('Next.js Setup with SSR', 40, '1 Frontend Dev'),
            ('Authentication Pages', 50, '1 Frontend Dev'),
            ('Home & Navigation', 60, '1 Frontend Dev'),
            ('Product Catalog', 80, '1 Frontend Dev'),
            ('Custom Box Creator', 100, '1 Frontend Dev'),
            ('Checkout Flow', 80, '1 Frontend Dev'),
            ('User Dashboard', 60, '1 Frontend Dev'),
            ('Order Management', 60, '1 Frontend Dev'),
            ('Admin Dashboard', 120, '2 Frontend Devs'),
            ('Analytics & Reporting', 80, '1 Frontend Dev')
        ],
        'color': colors['web'],
        'team': ['Frontend Dev (2)', 'Designer (0.5)']
    },
    'Phase 5: Integration & Testing': {
        'duration_weeks': 4,
        'tasks': [
            ('API Integration Testing', 80, '1 QA'),
            ('Cross-platform Testing', 100, '2 QA'),
            ('Payment Gateway Testing', 60, '1 QA + 1 Dev'),
            ('E2E User Testing', 80, '2 QA'),
            ('Performance Optimization', 60, '1 Backend + 1 Frontend'),
            ('Security Audit', 40, '1 DevOps'),
            ('Bug Fixes', 120, 'All Devs')
        ],
        'color': colors['testing'],
        'team': ['QA (2)', 'All Devs (3)', 'DevOps (1)']
    },
    'Phase 6: Deployment': {
        'duration_weeks': 2,
        'tasks': [
            ('Server Setup', 40, '1 DevOps'),
            ('Database Migration', 30, '1 Backend Dev + DevOps'),
            ('App Store Submissions', 40, '1 Mobile Dev'),
            ('Web Hosting & CDN', 30, '1 DevOps'),
            ('Beta Testing', 60, '2 QA'),
            ('Launch Preparation', 30, 'PM + Team'),
            ('Documentation', 40, 'All Devs')
        ],
        'color': colors['deployment'],
        'team': ['DevOps (1)', 'QA (2)', 'PM (1)', 'All Devs (1)']
    },
    'Phase 7: Post-Launch Support': {
        'duration_weeks': 4,
        'tasks': [
            ('Bug Monitoring', 80, '1 Backend + 1 Mobile'),
            ('User Feedback Implementation', 60, 'All Devs'),
            ('Performance Monitoring', 40, '1 DevOps'),
            ('Minor Enhancements', 80, 'All Devs')
        ],
        'color': colors['support'],
        'team': ['All Devs (2)', 'DevOps (0.5)', 'QA (1)']
    }
}

# Calculate start and end dates
def calculate_timeline():
    start_date = datetime(2025, 11, 10)  # Starting next week
    timeline = []
    current_date = start_date
    
    for phase, data in project_data.items():
        end_date = current_date + timedelta(weeks=data['duration_weeks'])
        total_hours = sum(task[1] for task in data['tasks'])
        
        timeline.append({
            'phase': phase,
            'start': current_date,
            'end': end_date,
            'duration_weeks': data['duration_weeks'],
            'total_hours': total_hours,
            'color': data['color'],
            'tasks': data['tasks'],
            'team': data['team']
        })
        
        # Phases can overlap for parallel development
        if 'Backend' in phase:
            current_date = start_date + timedelta(weeks=2)  # After planning
        elif 'Mobile' in phase:
            current_date = start_date + timedelta(weeks=4)  # After backend starts
        elif 'Web' in phase:
            current_date = start_date + timedelta(weeks=4)  # Parallel with mobile
        elif 'Testing' in phase:
            current_date = start_date + timedelta(weeks=12)  # After dev phases
        elif 'Deployment' in phase:
            current_date = start_date + timedelta(weeks=16)  # After testing
        elif 'Support' in phase:
            current_date = start_date + timedelta(weeks=18)  # After deployment
        else:
            current_date = end_date
    
    return timeline

# Generate Gantt Chart
def create_gantt_chart(timeline):
    fig, ax = plt.subplots(figsize=(16, 10))
    
    # Plot each phase
    for idx, phase_data in enumerate(timeline):
        start = phase_data['start']
        duration = (phase_data['end'] - phase_data['start']).days
        
        ax.barh(idx, duration, left=start.toordinal(), 
                color=phase_data['color'], alpha=0.8, height=0.6,
                edgecolor='white', linewidth=2)
        
        # Add phase label with hours
        phase_label = phase_data['phase'].replace('Phase ', 'P')
        hours_label = f"{phase_data['total_hours']}h"
        ax.text(start.toordinal() + duration/2, idx, 
               f"{phase_label}\n{hours_label}",
               ha='center', va='center', fontsize=9, fontweight='bold',
               color='white')
    
    # Format x-axis
    start_ord = min(p['start'].toordinal() for p in timeline)
    end_ord = max(p['end'].toordinal() for p in timeline)
    
    date_range = [datetime.fromordinal(int(x)) for x in 
                  np.linspace(start_ord, end_ord, 12)]
    ax.set_xticks([d.toordinal() for d in date_range])
    ax.set_xticklabels([d.strftime('%b %d\n%Y') for d in date_range], 
                       fontsize=9, rotation=0)
    
    # Format y-axis
    ax.set_yticks(range(len(timeline)))
    ax.set_yticklabels([p['phase'] for p in timeline], fontsize=10)
    
    # Styling
    ax.set_xlabel('Timeline', fontsize=12, fontweight='bold')
    ax.set_title('SavoyConnect Project Timeline (Gantt Chart)\nMySQL + Laravel + Flutter + Next.js', 
                 fontsize=16, fontweight='bold', pad=20)
    ax.grid(True, axis='x', alpha=0.3, linestyle='--')
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    
    plt.tight_layout()
    plt.savefig('timeline_gantt_chart.png', dpi=300, bbox_inches='tight')
    print("✓ Generated: timeline_gantt_chart.png")

# Generate Resource Allocation Chart
def create_resource_chart(timeline):
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(16, 12))
    
    # Chart 1: Man-hours by phase
    phases = [p['phase'].replace('Phase ', 'P').replace(': ', '\n') for p in timeline]
    hours = [p['total_hours'] for p in timeline]
    colors_list = [p['color'] for p in timeline]
    
    bars = ax1.bar(phases, hours, color=colors_list, alpha=0.8, 
                   edgecolor='white', linewidth=2)
    
    # Add value labels on bars
    for bar, hour in zip(bars, hours):
        height = bar.get_height()
        ax1.text(bar.get_x() + bar.get_width()/2., height,
                f'{int(hour)}h\n({int(hour/40)} weeks)',
                ha='center', va='bottom', fontsize=9, fontweight='bold')
    
    ax1.set_ylabel('Man-Hours', fontsize=12, fontweight='bold')
    ax1.set_title('Resource Allocation by Phase', fontsize=14, fontweight='bold')
    ax1.grid(True, axis='y', alpha=0.3, linestyle='--')
    ax1.spines['top'].set_visible(False)
    ax1.spines['right'].set_visible(False)
    
    # Chart 2: Team composition
    team_data = []
    for p in timeline:
        team_data.append({
            'phase': p['phase'].replace('Phase ', 'P'),
            'team': '\n'.join(p['team'])
        })
    
    y_pos = np.arange(len(team_data))
    ax2.barh(y_pos, [1] * len(team_data), color=colors_list, alpha=0.8,
            edgecolor='white', linewidth=2)
    
    # Add team labels
    for idx, data in enumerate(team_data):
        ax2.text(0.5, idx, data['team'], 
                ha='center', va='center', fontsize=9, fontweight='bold',
                color='white')
    
    ax2.set_yticks(y_pos)
    ax2.set_yticklabels([d['phase'] for d in team_data], fontsize=10)
    ax2.set_xlabel('Team Composition', fontsize=12, fontweight='bold')
    ax2.set_title('Required Team Members by Phase', fontsize=14, fontweight='bold')
    ax2.set_xticks([])
    ax2.spines['top'].set_visible(False)
    ax2.spines['right'].set_visible(False)
    ax2.spines['bottom'].set_visible(False)
    
    plt.tight_layout()
    plt.savefig('resource_allocation.png', dpi=300, bbox_inches='tight')
    print("✓ Generated: resource_allocation.png")

# Generate Phase Breakdown Chart
def create_phase_breakdown(timeline):
    # Create subplots for top 3 phases
    fig, axes = plt.subplots(2, 2, figsize=(18, 12))
    axes = axes.flatten()
    
    top_phases = sorted(timeline, key=lambda x: x['total_hours'], reverse=True)[:4]
    
    for idx, phase_data in enumerate(top_phases):
        ax = axes[idx]
        
        tasks = phase_data['tasks']
        task_names = [t[0][:25] + '...' if len(t[0]) > 25 else t[0] for t in tasks]
        task_hours = [t[1] for t in tasks]
        
        bars = ax.barh(task_names, task_hours, color=phase_data['color'], 
                      alpha=0.8, edgecolor='white', linewidth=1.5)
        
        # Add hour labels
        for bar, hours in zip(bars, task_hours):
            width = bar.get_width()
            ax.text(width, bar.get_y() + bar.get_height()/2,
                   f' {int(hours)}h',
                   ha='left', va='center', fontsize=8, fontweight='bold')
        
        ax.set_xlabel('Hours', fontsize=10, fontweight='bold')
        ax.set_title(phase_data['phase'], fontsize=11, fontweight='bold')
        ax.grid(True, axis='x', alpha=0.3, linestyle='--')
        ax.spines['top'].set_visible(False)
        ax.spines['right'].set_visible(False)
    
    fig.suptitle('Detailed Task Breakdown (Top 4 Phases)', 
                 fontsize=16, fontweight='bold', y=0.995)
    plt.tight_layout()
    plt.savefig('phase_breakdown.png', dpi=300, bbox_inches='tight')
    print("✓ Generated: phase_breakdown.png")

# Generate Summary Statistics
def create_summary_chart(timeline):
    fig = plt.figure(figsize=(16, 10))
    gs = fig.add_gridspec(3, 2, hspace=0.3, wspace=0.3)
    
    # Total project stats
    total_hours = sum(p['total_hours'] for p in timeline)
    total_weeks = max(p['end'] for p in timeline) - min(p['start'] for p in timeline)
    total_weeks_num = total_weeks.days / 7
    
    # 1. Project Overview (top spanning)
    ax1 = fig.add_subplot(gs[0, :])
    ax1.axis('off')
    
    overview_text = f"""
    PROJECT: SavoyConnect - Ice Cream Ordering Platform
    TECH STACK: MySQL + Laravel (Backend) + Flutter (Mobile) + Next.js (Web)
    
    TOTAL DURATION: {int(total_weeks_num)} weeks ({total_weeks.days} days)
    TOTAL MAN-HOURS: {int(total_hours)} hours ({int(total_hours/160)} person-months)
    
    START DATE: {min(p['start'] for p in timeline).strftime('%B %d, %Y')}
    END DATE: {max(p['end'] for p in timeline).strftime('%B %d, %Y')}
    """
    
    ax1.text(0.5, 0.5, overview_text, ha='center', va='center',
            fontsize=13, fontweight='bold', family='monospace',
            bbox=dict(boxstyle='round', facecolor='lightblue', alpha=0.8))
    
    # 2. Hours by phase (pie chart)
    ax2 = fig.add_subplot(gs[1, 0])
    phase_names = [p['phase'].replace('Phase ', 'P').replace(': ', '\n') 
                   for p in timeline]
    phase_hours = [p['total_hours'] for p in timeline]
    phase_colors = [p['color'] for p in timeline]
    
    wedges, texts, autotexts = ax2.pie(phase_hours, labels=phase_names, 
                                        colors=phase_colors, autopct='%1.1f%%',
                                        startangle=90, textprops={'fontsize': 9})
    for autotext in autotexts:
        autotext.set_color('white')
        autotext.set_fontweight('bold')
    
    ax2.set_title('Man-Hours Distribution', fontsize=12, fontweight='bold')
    
    # 3. Timeline visualization
    ax3 = fig.add_subplot(gs[1, 1])
    phases_simple = [p['phase'].replace('Phase ', 'P') for p in timeline]
    durations = [p['duration_weeks'] for p in timeline]
    
    bars = ax3.barh(phases_simple, durations, color=phase_colors, 
                   alpha=0.8, edgecolor='white', linewidth=2)
    
    for bar, dur in zip(bars, durations):
        width = bar.get_width()
        ax3.text(width, bar.get_y() + bar.get_height()/2,
                f' {int(dur)}w',
                ha='left', va='center', fontsize=9, fontweight='bold')
    
    ax3.set_xlabel('Weeks', fontsize=10, fontweight='bold')
    ax3.set_title('Phase Duration', fontsize=12, fontweight='bold')
    ax3.grid(True, axis='x', alpha=0.3, linestyle='--')
    ax3.spines['top'].set_visible(False)
    ax3.spines['right'].set_visible(False)
    
    # 4. Team requirements
    ax4 = fig.add_subplot(gs[2, :])
    
    team_req = """
    RECOMMENDED TEAM COMPOSITION:
    
    • Backend Developers (Laravel):     2 developers (full-time)
    • Mobile Developers (Flutter):      2 developers (full-time)
    • Frontend Developers (Next.js):    2 developers (full-time)
    • UI/UX Designer:                    1 designer (part-time after planning phase)
    • QA Engineers:                      2 testers (testing & deployment phases)
    • DevOps Engineer:                   1 engineer (part-time, critical in deployment)
    • Project Manager:                   1 PM (full-time throughout)
    
    PEAK RESOURCE NEED: 8-10 team members (during development phases)
    AVERAGE TEAM SIZE: 6-7 members
    """
    
    ax4.text(0.1, 0.5, team_req, ha='left', va='center',
            fontsize=11, family='monospace',
            bbox=dict(boxstyle='round', facecolor='lightgreen', alpha=0.6))
    ax4.axis('off')
    
    fig.suptitle('SavoyConnect Project Summary', fontsize=18, fontweight='bold')
    plt.savefig('project_summary.png', dpi=300, bbox_inches='tight')
    print("✓ Generated: project_summary.png")

# Generate Excel report
def create_excel_report(timeline):
    # Create detailed breakdown
    all_data = []
    
    for phase_data in timeline:
        phase_name = phase_data['phase']
        for task in phase_data['tasks']:
            all_data.append({
                'Phase': phase_name,
                'Task': task[0],
                'Hours': task[1],
                'Days': round(task[1] / 8, 1),
                'Resource': task[2],
                'Start Date': phase_data['start'].strftime('%Y-%m-%d'),
                'End Date': phase_data['end'].strftime('%Y-%m-%d')
            })
    
    df = pd.DataFrame(all_data)
    
    # Create summary sheet
    summary_data = []
    for phase_data in timeline:
        summary_data.append({
            'Phase': phase_data['phase'],
            'Duration (weeks)': phase_data['duration_weeks'],
            'Total Hours': phase_data['total_hours'],
            'Person-Weeks': round(phase_data['total_hours'] / 40, 1),
            'Start Date': phase_data['start'].strftime('%Y-%m-%d'),
            'End Date': phase_data['end'].strftime('%Y-%m-%d'),
            'Team': ', '.join(phase_data['team'])
        })
    
    df_summary = pd.DataFrame(summary_data)
    
    # Write to Excel with multiple sheets
    with pd.ExcelWriter('savoyconnect_timeline.xlsx', engine='openpyxl') as writer:
        df_summary.to_excel(writer, sheet_name='Summary', index=False)
        df.to_excel(writer, sheet_name='Detailed Tasks', index=False)
    
    print("✓ Generated: savoyconnect_timeline.xlsx")

# Main execution
def main():
    print("\n" + "="*60)
    print("  SavoyConnect Project Timeline Generator")
    print("  MySQL + Laravel + Flutter + Next.js")
    print("="*60 + "\n")
    
    print("Calculating project timeline...")
    timeline = calculate_timeline()
    
    print(f"\nGenerating visualizations...")
    print("-" * 60)
    
    create_gantt_chart(timeline)
    create_resource_chart(timeline)
    create_phase_breakdown(timeline)
    create_summary_chart(timeline)
    create_excel_report(timeline)
    
    print("-" * 60)
    print("\n✓ All visualizations generated successfully!")
    print("\nGenerated files:")
    print("  1. timeline_gantt_chart.png - Full project Gantt chart")
    print("  2. resource_allocation.png - Man-hours and team composition")
    print("  3. phase_breakdown.png - Detailed task breakdown")
    print("  4. project_summary.png - Executive summary")
    print("  5. savoyconnect_timeline.xlsx - Detailed Excel report")
    
    # Calculate totals
    total_hours = sum(p['total_hours'] for p in timeline)
    total_weeks = max(p['end'] for p in timeline) - min(p['start'] for p in timeline)
    
    print(f"\nProject Summary:")
    print(f"  • Total Duration: {int(total_weeks.days / 7)} weeks")
    print(f"  • Total Man-Hours: {int(total_hours)} hours")
    print(f"  • Estimated Team Size: 6-8 members")
    print(f"  • Start Date: {min(p['start'] for p in timeline).strftime('%B %d, %Y')}")
    print(f"  • Target Completion: {max(p['end'] for p in timeline).strftime('%B %d, %Y')}")
    print("\n" + "="*60 + "\n")

if __name__ == "__main__":
    main()
