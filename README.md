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
