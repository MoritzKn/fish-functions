function pdfcomp --description 'Compress a pdf'
    for f in $argv
        set -l orgFile (basename -s .pdf $f)-original.pdf
        mv $f $orgFile || return 1
        echo "==> Compressing $f..."
        gs -sDEVICE=pdfwrite \
            -dCompatibilityLevel=2 \
            -dPDFSETTINGS=/ebook \
            -dNOPAUSE -dQUIET -dBATCH \
            -sOutputFile=$f $orgFile
    end
end
