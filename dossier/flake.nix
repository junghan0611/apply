{
  description = "NHN AX 제출 문서 — 하나의 Org 정본에서 PDF·ODT/DOC·Markdown 세트를 재현 가능하게";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAll (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # scheme-medium 은 acmart 를 담지 않는다. 호스트 texlive 로는 이 문서가 빌드되지
          # 않으므로(kpsewhich acmart.cls → 없음) 조판 클래스와 한글 엔진을 여기에 묶는다.
          tex = pkgs.texlive.combine {
            inherit (pkgs.texlive)
              scheme-medium
              collection-latexextra
              latexmk
              acmart
              newtx
              libertine
              xetexko
              kotex-utf;
          };

          # 폰트는 빌드 입력이다. 받는 쪽에 폰트가 없으면 XeTeX 는 조용히 대체 폰트로
          # 조판하고 페이지는 멀쩡히 나온다 — 실패가 눈에 보이지 않는 종류라서, 문서가
          # "특정 기계에서만 같은 얼굴로 나오는" 상태를 재현성이라 부를 수 없다.
          #
          # Pretendard 를 쓰는 이유는 취향이 아니라 인덱싱이다. Noto CJK 는 스크립트당
          # 가변 웨이트 TTC 한 덩어리로 배포되는데 xetexko 가 그 안을 가리키지 못해
          # `Invalid TTC index number` 로 멈춘다. Pretendard 는 굵기마다 정적 OTF 라
          # 패밀리 이름 해석이 그대로 통한다. 함초롬바탕은 nixpkgs 에 없어 제외했다.
          fonts = [ pkgs.pretendard pkgs.d2coding ];
          fontsConf = pkgs.makeFontsConf { fontDirectories = fonts; };
        in {
          default = pkgs.mkShell {
            packages = [
              pkgs.emacs        # org → odt / org → latex
              pkgs.pandoc       # org → gfm
              pkgs.poppler-utils # pdfinfo / pdftotext — 검수 게이트
              pkgs.gnumake
              pkgs.python3      # odt 후처리
              pkgs.zip
              pkgs.fontconfig
              tex
            ] ++ fonts;

            # 호스트 폰트 캐시를 상속하지 않는다. 위 주석의 이유.
            FONTCONFIG_FILE = fontsConf;
          };
        });
    };
}
