# texlive-docker

dockerにてtexliveが動くubuntuイメージをビルドします。  
M1 Macにて動作確認済みです。  
新たに必要なスタイルファイルやTeXスタイルなどは、`Dockerfile`の`tlmgr install ********`に追加してください。  

```
docker run --rm -v ${PWD}:/texsrc texlive-docker platex sample.tex
docker run --rm -v ${PWD}:/texsrc texlive-docker pbibtex sample
docker run --rm -v ${PWD}:/texsrc texlive-docker dvipdfmx sample
```

参考: https://qiita.com/myoshimi/items/22f65816944abbdce050

## vscode latexレシピ
```
{
    "latex-workshop.latex.recipes": [
        {
            "name": "texlive-UpLatex",
            "tools": [
                "docker-upLatex",
                "docker-sed",
                "docker-upbibtex",
                "docker-dvipdfmx"
            ]
        },
        {
            "name": "texlive-pLatex",
            "tools": [
                "docker-pLatex",
                "docker-sed",
                "docker-pbibtex",
                "docker-dvipdfmx"
            ]
        },
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "docker-pLatex",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%WORKSPACE_FOLDER%:/texsrc",
                "-w",
                "/texsrc/%RELATIVE_DIR%",
                "texlive-docker",
                "platex",
                "-synctex=1",
                "-jobname=%DOCFILE%",
                "-kanji=utf8",
                "-halt-on-error",
                "%DOCFILE%",
            ],
            "env": {}
        },
        {
            "name": "docker-upLatex",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%WORKSPACE_FOLDER%:/texsrc",
                "-w",
                "/texsrc/%RELATIVE_DIR%",
                "texlive-docker",
                "uplatex",
                "-synctex=1",
                "-jobname=%DOCFILE%",
                "-kanji=utf8",
                "-halt-on-error",
                "%DOCFILE%",
            ],
            "env": {}
        },
        {
            "name": "docker-sed",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%WORKSPACE_FOLDER%:/texsrc",
                "-w",
                "/texsrc/%RELATIVE_DIR%",
                "texlive-docker",
                "bash",
                "-c",
                "cat %DOCFILE%.synctex.gz | gzip -d |sed -e 's@/texsrc@%WORKSPACE_FOLDER%@' | gzip -c > %DOCFILE%.synctex.gz" 
            ],
            "env": {}
        },
        {
            "name": "docker-pbibtex",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%WORKSPACE_FOLDER%:/texsrc",
                "-w",
                "/texsrc/%RELATIVE_DIR%",
                "texlive-docker",
                "bash",
                "-c",
                "pbibtex %DOCFILE% || echo finish"
            ],
            "env": {}
        },
        {
            "name": "docker-upbibtex",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%WORKSPACE_FOLDER%:/texsrc",
                "-w",
                "/texsrc/%RELATIVE_DIR%",
                "texlive-docker",
                "bash",
                "-c",
                "upbibtex %DOCFILE% || echo finish"
            ],
            "env": {}
        },
        {
            "name": "docker-dvipdfmx",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%WORKSPACE_FOLDER%:/texsrc",
                "-w",
                "/texsrc/%RELATIVE_DIR%",
                "texlive-docker",
                "dvipdfmx",
                "%DOCFILE%"
            ],
            "env": {}
        }
    ]
}
```
