% creates extra space between label and definition (dates and job description in CV)
\renewcommand\descriptionlabel[1]{
  \hspace\labelsep {
    \advance\linewidth\leftmargin
    \advance\linewidth-\labelsep
    \makebox[\linewidth][l]{\raisebox{0.5\height}[2\height]{\large{#1}}}}}
