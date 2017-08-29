# Defined in - @ line 2
function pdfcomp --description 'Compress a pdf'
    echo gs -sDEVICE=pdfwrite -dCompatibilityLevel=2 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=(basename -s .pdf $argv[1])-comp.pdf $argv[1]
end
