"""
Generate LaTeX document for SavoyConnect Project Timeline
Single-person man-hour estimates
"""

from datetime import datetime, timedelta

def generate_latex_timeline():
    # Project data - single person estimates (sequential work)
    project_data = {
        'Phase 1: Planning & Design': {
            'tasks': [
                ('Requirements Documentation', 40),
                ('Database Schema Design', 60),
                ('API Specifications', 50),
                ('UI/UX Refinement', 80),
                ('Architecture Documentation', 40),
                ('Sprint Planning', 20)
            ],
            'color': 'blue!30'
        },
        'Phase 2: Backend Development (Laravel + MySQL)': {
            'tasks': [
                ('Database Setup & Migrations', 60),
                ('Authentication & Authorization System', 80),
                ('User Management APIs', 60),
                ('Product Catalog APIs', 80),
                ('Order Management System', 120),
                ('Payment Gateway Integration', 100),
                ('Delivery Management System', 80),
                ('Admin Panel APIs', 100),
                ('Loyalty Points Calculation Engine', 60),
                ('Notification Service Setup', 40)
            ],
            'color': 'red!30'
        },
        'Phase 3: Mobile App Development (Flutter)': {
            'tasks': [
                ('Flutter Project Setup & Architecture', 40),
                ('Authentication Screens', 60),
                ('Home Feed & Navigation', 80),
                ('Product Browsing & Search', 100),
                ('Custom Box Builder Interface', 120),
                ('Shopping Cart & Checkout', 80),
                ('Payment Integration', 80),
                ('Order Tracking Interface', 60),
                ('User Profile & Wallet', 60),
                ('Loyalty Rewards Interface', 60),
                ('Push Notification Setup', 40),
                ('Recipe Sharing Features', 80)
            ],
            'color': 'green!30'
        },
        'Phase 4: Web Application Development (Next.js)': {
            'tasks': [
                ('Next.js Setup with SSR Configuration', 40),
                ('Authentication Pages', 50),
                ('Responsive Home & Navigation', 60),
                ('Product Catalog with Filtering', 80),
                ('Custom Box Creator', 100),
                ('Checkout Flow', 80),
                ('User Dashboard', 60),
                ('Order Management Interface', 60),
                ('Admin Dashboard', 120),
                ('Analytics & Reporting Pages', 80)
            ],
            'color': 'orange!30'
        },
        'Phase 5: Integration & Testing': {
            'tasks': [
                ('API Integration Testing', 80),
                ('Cross-platform Testing (iOS, Android, Web)', 100),
                ('Payment Gateway Testing', 60),
                ('End-to-End User Journey Testing', 80),
                ('Performance Optimization', 60),
                ('Security Audit', 40),
                ('Bug Fixes & Refinements', 120)
            ],
            'color': 'purple!30'
        },
        'Phase 6: Deployment & Launch': {
            'tasks': [
                ('Server Setup & Configuration', 40),
                ('Database Migration to Production', 30),
                ('App Store Submissions (iOS & Android)', 40),
                ('Web Hosting & CDN Setup', 30),
                ('Beta Testing with Real Users', 60),
                ('Launch Preparation & Marketing', 30),
                ('Documentation & User Guides', 40)
            ],
            'color': 'cyan!30'
        },
        'Phase 7: Post-Launch Support & Monitoring': {
            'tasks': [
                ('Bug Monitoring & Critical Fixes', 80),
                ('User Feedback Collection & Analysis', 40),
                ('Performance Monitoring & Optimization', 40),
                ('Minor Feature Enhancements', 80)
            ],
            'color': 'yellow!30'
        }
    }
    
    # Calculate totals
    phase_totals = {}
    grand_total = 0
    
    for phase, data in project_data.items():
        total = sum(task[1] for task in data['tasks'])
        phase_totals[phase] = total
        grand_total += total
    
    # Start generating LaTeX
    latex_content = r"""\documentclass[11pt,a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{geometry}
\usepackage{graphicx}
\usepackage{xcolor}
\usepackage{longtable}
\usepackage{booktabs}
\usepackage{array}
\usepackage{multirow}
\usepackage{tikz}
\usepackage{pgfplots}
\usepackage{fancyhdr}
\usepackage{titlesec}
\usepackage{enumitem}
\usepackage{hyperref}
\usepackage{amsmath}

\geometry{left=2cm,right=2cm,top=2.5cm,bottom=2.5cm}
\pgfplotsset{compat=1.18}

% Colors
\definecolor{primaryblue}{RGB}{0,82,204}
\definecolor{secondaryblue}{RGB}{0,102,255}
\definecolor{accentpink}{RGB}{255,51,102}

% Header and Footer
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\textcolor{primaryblue}{\textbf{SavoyConnect Project Timeline}}}
\fancyhead[R]{\textcolor{gray}{November 2025}}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{2pt}
\renewcommand{\headrule}{\hbox to\headwidth{\color{primaryblue}\leaders\hrule height \headrulewidth\hfill}}

% Title formatting
\titleformat{\section}
  {\Large\bfseries\color{primaryblue}}
  {\thesection}{1em}{}[\titlerule]

\titleformat{\subsection}
  {\large\bfseries\color{secondaryblue}}
  {\thesubsection}{1em}{}

\hypersetup{
    colorlinks=true,
    linkcolor=primaryblue,
    urlcolor=secondaryblue,
    citecolor=accentpink
}

\begin{document}

% Title Page
\begin{titlepage}
    \centering
    \vspace*{2cm}
    
    {\Huge\bfseries\color{primaryblue} SavoyConnect\par}
    \vspace{0.5cm}
    {\LARGE\color{accentpink} Project Timeline \& Resource Estimation\par}
    \vspace{2cm}
    
    {\Large\textbf{Single Developer Implementation Plan}\par}
    \vspace{1cm}
    
    \begin{tikzpicture}
        \draw[primaryblue, line width=2pt] (0,0) -- (12,0);
    \end{tikzpicture}
    
    \vspace{2cm}
    
    \begin{tabular}{ll}
        \textbf{Tech Stack:} & MySQL + Laravel + Flutter + Next.js \\
        \textbf{Project Type:} & Ice Cream Ordering \& Delivery Platform \\
        \textbf{Estimated Duration:} & """ + str(round(grand_total/160, 1)) + r""" months \\
        \textbf{Total Man-Hours:} & """ + str(grand_total) + r""" hours \\
        \textbf{Document Date:} & November 3, 2025 \\
    \end{tabular}
    
    \vfill
    
    {\large Prepared for: Management Review \& Planning\par}
    
\end{titlepage}

\tableofcontents
\newpage

\section{Executive Summary}

\subsection{Project Overview}
SavoyConnect is a comprehensive ice cream ordering and delivery platform featuring custom box creation, loyalty rewards, social features, and real-time order tracking. This document provides a detailed timeline and resource estimation for a \textbf{single developer} implementing the entire system.

\subsection{Key Metrics}

\begin{table}[h]
\centering
\begin{tabular}{|l|r|}
\hline
\rowcolor{primaryblue!20}
\textbf{Metric} & \textbf{Value} \\
\hline
Total Man-Hours & """ + str(grand_total) + r""" hours \\
\hline
Full-Time Equivalent & """ + str(round(grand_total/160, 1)) + r""" months (160 hrs/month) \\
\hline
Working Days (8 hrs/day) & """ + str(round(grand_total/8)) + r""" days \\
\hline
Working Weeks (40 hrs/week) & """ + str(round(grand_total/40)) + r""" weeks \\
\hline
Calendar Months (Estimate) & """ + str(round(grand_total/160, 1)) + r""" months \\
\hline
Development Phases & 7 phases \\
\hline
\end{tabular}
\caption{Project Resource Summary}
\end{table}

\subsection{Technology Stack}

\begin{itemize}[leftmargin=2cm]
    \item \textbf{Backend:} Laravel (PHP) - RESTful API, Authentication, Business Logic
    \item \textbf{Database:} MySQL - Relational Database Management
    \item \textbf{Mobile App:} Flutter - Cross-platform (iOS \& Android)
    \item \textbf{Web Application:} Next.js (React) - Server-Side Rendering
    \item \textbf{Additional:} Payment Gateway, Push Notifications, Real-time Tracking
\end{itemize}

\subsection{Assumptions}

\begin{enumerate}
    \item Single developer working full-time (8 hours/day, 40 hours/week)
    \item Developer proficient in all required technologies
    \item No major scope changes during development
    \item Third-party services (payment gateway, hosting) readily available
    \item Standard complexity for integrations
\end{enumerate}

\newpage

\section{Phase Breakdown}

"""
    
    # Generate phase details
    phase_num = 1
    for phase, data in project_data.items():
        total_hours = sum(task[1] for task in data['tasks'])
        weeks = round(total_hours / 40, 1)
        
        latex_content += f"\n\\subsection{{Phase {phase_num}: {phase.replace('Phase ' + str(phase_num) + ': ', '')}}}\n\n"
        latex_content += f"\\textbf{{Duration:}} {total_hours} hours ({weeks} weeks at 40 hrs/week)\n\n"
        
        latex_content += "\\begin{longtable}{|p{8cm}|r|r|}\n"
        latex_content += "\\hline\n"
        latex_content += "\\rowcolor{" + data['color'] + "}\n"
        latex_content += "\\textbf{Task} & \\textbf{Hours} & \\textbf{Days (8h)} \\\\\n"
        latex_content += "\\hline\n"
        latex_content += "\\endfirsthead\n\n"
        latex_content += "\\hline\n"
        latex_content += "\\rowcolor{" + data['color'] + "}\n"
        latex_content += "\\textbf{Task} & \\textbf{Hours} & \\textbf{Days (8h)} \\\\\n"
        latex_content += "\\hline\n"
        latex_content += "\\endhead\n\n"
        
        for task_name, task_hours in data['tasks']:
            days = round(task_hours / 8, 1)
            latex_content += f"{task_name} & {task_hours} & {days} \\\\\n"
            latex_content += "\\hline\n"
        
        latex_content += "\\rowcolor{gray!20}\n"
        latex_content += f"\\textbf{{Phase {phase_num} Total}} & \\textbf{{{total_hours}}} & \\textbf{{{round(total_hours/8, 1)}}} \\\\\n"
        latex_content += "\\hline\n"
        latex_content += f"\\caption{{Phase {phase_num} Task Breakdown}}\n"
        latex_content += "\\end{longtable}\n\n"
        
        phase_num += 1
    
    # Timeline visualization section
    latex_content += r"""
\newpage

\section{Visual Timeline}

\subsection{Man-Hours Distribution by Phase}

\begin{center}
\begin{tikzpicture}
    \begin{axis}[
        ybar,
        bar width=25pt,
        width=0.95\textwidth,
        height=8cm,
        ylabel={Man-Hours},
        symbolic x coords={P1,P2,P3,P4,P5,P6,P7},
        xtick=data,
        nodes near coords,
        nodes near coords align={vertical},
        ymin=0,
        legend style={at={(0.5,-0.15)}, anchor=north,legend columns=-1},
        xlabel={Phase},
        title={Total Hours by Development Phase}
    ]
    \addplot[fill=blue!30] coordinates {
"""
    
    # Add phase data for bar chart
    phase_labels = ['P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7']
    for idx, (phase, data) in enumerate(project_data.items()):
        total_hours = sum(task[1] for task in data['tasks'])
        latex_content += f"        ({phase_labels[idx]},{total_hours})\n"
    
    latex_content += r"""    };
    \end{axis}
\end{tikzpicture}
\end{center}

\subsection{Cumulative Progress Chart}

\begin{center}
\begin{tikzpicture}
    \begin{axis}[
        width=0.95\textwidth,
        height=8cm,
        xlabel={Phase},
        ylabel={Cumulative Hours},
        symbolic x coords={Start,P1,P2,P3,P4,P5,P6,P7},
        xtick=data,
        legend pos=north west,
        grid=major
    ]
    \addplot[
        color=primaryblue,
        mark=*,
        thick
    ] coordinates {
"""
    
    # Calculate cumulative hours
    cumulative = 0
    latex_content += f"        (Start,0)\n"
    for idx, (phase, data) in enumerate(project_data.items()):
        total_hours = sum(task[1] for task in data['tasks'])
        cumulative += total_hours
        latex_content += f"        ({phase_labels[idx]},{cumulative})\n"
    
    latex_content += r"""    };
    \legend{Cumulative Man-Hours}
    \end{axis}
\end{tikzpicture}
\end{center}

"""
    
    # Add Gantt-style timeline table
    latex_content += r"""
\newpage

\section{Sequential Timeline (Gantt View)}

\subsection{Phase Schedule (Single Developer)}

Assuming continuous full-time work (40 hours/week), here is the sequential timeline:

\begin{longtable}{|l|r|r|r|r|}
\hline
\rowcolor{gray!30}
\textbf{Phase} & \textbf{Hours} & \textbf{Weeks} & \textbf{Start Week} & \textbf{End Week} \\
\hline
\endfirsthead

\hline
\rowcolor{gray!30}
\textbf{Phase} & \textbf{Hours} & \textbf{Weeks} & \textbf{Start Week} & \textbf{End Week} \\
\hline
\endhead

"""
    
    # Generate sequential timeline
    cumulative_weeks = 0
    for idx, (phase, data) in enumerate(project_data.items(), 1):
        total_hours = sum(task[1] for task in data['tasks'])
        weeks = round(total_hours / 40, 1)
        start_week = cumulative_weeks + 1
        end_week = cumulative_weeks + weeks
        
        latex_content += f"Phase {idx} & {total_hours} & {weeks} & {start_week} & {round(end_week, 1)} \\\\\n"
        latex_content += "\\hline\n"
        
        cumulative_weeks = end_week
    
    latex_content += "\\rowcolor{primaryblue!20}\n"
    latex_content += f"\\textbf{{TOTAL}} & \\textbf{{{grand_total}}} & \\textbf{{{round(grand_total/40, 1)}}} & \\textbf{{1}} & \\textbf{{{round(cumulative_weeks, 1)}}} \\\\\n"
    latex_content += "\\hline\n"
    latex_content += "\\caption{Sequential Phase Timeline}\n"
    latex_content += "\\end{longtable}\n\n"
    
    # Risk assessment and recommendations
    latex_content += r"""
\newpage

\section{Risk Assessment \& Mitigation}

\subsection{Technical Risks}

\begin{table}[h]
\centering
\begin{tabular}{|p{4cm}|p{3cm}|p{6cm}|}
\hline
\rowcolor{red!20}
\textbf{Risk} & \textbf{Probability} & \textbf{Mitigation Strategy} \\
\hline
Payment Gateway Integration Issues & Medium & Use well-documented gateways (Stripe), allocate buffer time \\
\hline
Cross-platform Compatibility & Medium & Regular testing on iOS \& Android devices, use Flutter best practices \\
\hline
Performance Issues & Low & Implement caching, optimize database queries, use CDN \\
\hline
Security Vulnerabilities & Medium & Regular security audits, follow OWASP guidelines, use Laravel security features \\
\hline
Scope Creep & High & Strict scope control, change request process, MVP-first approach \\
\hline
\end{tabular}
\caption{Risk Assessment Matrix}
\end{table}

\subsection{Resource Risks}

\begin{itemize}
    \item \textbf{Single Point of Failure:} One developer means no backup. Mitigation: Good documentation, version control, regular backups.
    \item \textbf{Skill Gaps:} Developer may need learning time for specific technologies. Buffer time included in estimates.
    \item \textbf{Burnout:} Long solo project can lead to fatigue. Recommendation: Regular breaks, realistic scheduling.
\end{itemize}

\subsection{Timeline Risks}

\begin{itemize}
    \item \textbf{Underestimation:} Tasks may take longer than estimated (+20-30\% buffer recommended).
    \item \textbf{Unforeseen Challenges:} Technical blockers, API changes, third-party service issues.
    \item \textbf{Testing Overhead:} Manual testing across platforms is time-consuming.
\end{itemize}

\section{Recommendations}

\subsection{For Management}

\begin{enumerate}
    \item \textbf{Add 25-30\% Buffer:} Realistic timeline should account for unknowns (""" + str(round(grand_total * 1.25)) + r"""-""" + str(round(grand_total * 1.3)) + r""" hours total).
    \item \textbf{Consider MVP Approach:} Launch core features first, iterate with user feedback.
    \item \textbf{Quality Assurance:} Budget for external QA or beta testing to reduce developer testing burden.
    \item \textbf{Infrastructure Ready:} Ensure servers, domains, payment accounts are set up before deployment phase.
\end{enumerate}

\subsection{For Developer}

\begin{enumerate}
    \item \textbf{Prioritize Core Features:} Authentication, ordering, payment must be rock-solid.
    \item \textbf{Use Boilerplates:} Laravel starter kits, Flutter templates can save 20-30 hours.
    \item \textbf{Automated Testing:} Write unit tests for critical backend logic (saves debugging time).
    \item \textbf{Version Control:} Commit regularly, use branches for features.
    \item \textbf{Documentation:} Document as you go, especially API endpoints and data models.
\end{enumerate}

\subsection{Success Metrics}

\begin{itemize}
    \item Complete each phase within 10\% of estimated hours
    \item Zero critical bugs in production launch
    \item App store approval on first submission
    \item 95\%+ uptime in first month post-launch
    \item Positive user feedback on core features
\end{itemize}

\newpage

\section{Appendix}

\subsection{A. Technology Justification}

\textbf{Laravel (Backend):}
\begin{itemize}
    \item Rapid development with built-in auth, ORM, validation
    \item Large ecosystem and community support
    \item Estimated time savings: 50+ hours vs. building from scratch
\end{itemize}

\textbf{Flutter (Mobile):}
\begin{itemize}
    \item Single codebase for iOS \& Android (saves 400+ hours vs. native)
    \item Native performance and UI components
    \item Hot reload speeds up development
\end{itemize}

\textbf{Next.js (Web):}
\begin{itemize}
    \item SEO-friendly with SSR
    \item Fast development with React ecosystem
    \item Easy deployment on Vercel/Netlify
\end{itemize}

\textbf{MySQL (Database):}
\begin{itemize}
    \item Familiar, well-documented
    \item ACID compliance for transactions
    \item Free and open-source
\end{itemize}

\subsection{B. Development Environment Setup}

Estimated time: 8-10 hours (included in Phase 1)

\begin{itemize}
    \item Local development: XAMPP/Laravel Valet (2 hours)
    \item Flutter SDK \& Android Studio/Xcode (3 hours)
    \item Node.js \& Next.js setup (1 hour)
    \item Version control (Git/GitHub) (1 hour)
    \item Database tools (MySQL Workbench, TablePlus) (1 hour)
    \item API testing tools (Postman, Insomnia) (1 hour)
\end{itemize}

\subsection{C. Glossary}

\begin{description}
    \item[API] Application Programming Interface
    \item[CRUD] Create, Read, Update, Delete operations
    \item[SSR] Server-Side Rendering
    \item[ORM] Object-Relational Mapping
    \item[MVP] Minimum Viable Product
    \item[QA] Quality Assurance
    \item[CDN] Content Delivery Network
    \item[OWASP] Open Web Application Security Project
\end{description}

\subsection{D. Contact \& Support}

For questions or clarifications regarding this timeline:

\begin{itemize}
    \item Project Manager: [Contact Information]
    \item Technical Lead: [Contact Information]
    \item Documentation: Project repository README.md
\end{itemize}

\vfill

\begin{center}
\begin{tikzpicture}
    \draw[primaryblue, line width=2pt] (0,0) -- (15,0);
\end{tikzpicture}

\vspace{0.5cm}

\textit{Document Generated: November 3, 2025} \\
\textit{SavoyConnect - Your Ice Cream Journey Begins}

\end{center}

\end{document}
"""
    
    return latex_content

# Generate and save
if __name__ == "__main__":
    print("\nGenerating LaTeX timeline document...")
    latex_content = generate_latex_timeline()
    
    with open('savoyconnect_timeline.tex', 'w', encoding='utf-8') as f:
        f.write(latex_content)
    
    print("✓ Generated: savoyconnect_timeline.tex")
    print("\nTo compile to PDF:")
    print("  pdflatex savoyconnect_timeline.tex")
    print("  (run twice for table of contents)")
    print("\nTotal project estimate: Single developer, 3,730 hours (~23 months or ~93 weeks)")
