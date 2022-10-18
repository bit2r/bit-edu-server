# OS와 무관한 데이터 과학 `개발 환경` 구성

author: joygram@gmail.com

## 컨테이너 기반 환경 구성

```
Don't reinvent the wheel
```

여러 선배님들과 엔니지어 분들이 이 원칙을  잘 준수하여 준 덕분에 현재 소프트웨어의 생태계(eco system)는 어느때보다 잘 실현이 되었다고 봅니다.

### 패키지 매니져

하지만 그로 인한 부작용 역시 있었으니 `dll`, `패키지`가 무수히 많아지고 라이프 사이클이 길어지는 대신 다양한 버젼간의 충돌이 발생하게 되었습니다.

그것을 해소하기 위해 버젼에 대한 의존성과 패키지의 관리를 위한 여러 노력들이 다양한 프로그래밍 환경에 적용되기 시작하였습니다.

### 가상환경

다양한 환경의 의존성이 있는 프로젝트를 여러개를 진행하는 경우 패키지 매니져를 통해서도 해결할 수 없는 경우가 종종 발생하기 시작하였고 특히, 데이터 과학 분야 쪽은 사용하는 프로젝트 기반의 세대와 발전속도가 비약적으로 증가함에 따라 또다른 방식의 해결방식이 필요하게 되었습니다.

우리가 자주 사용하는  `conda`, `venv`, `renv` 와 같은 독립환경 구성등이 그 예 라고 할 수 있습니다.

### 컨테이너 기반 환경 구성

컨테디너 기반 환경구성의 필요성이 대두된 것은 어제 오늘 일은 아닙니다. 이전에는 `가상머신` 기반의 구성으로 os기반을 확장하였으나 그것이 점차 `컨테이너 기반 방식`으로 변화하게 됩니다. 컴퓨팅 환경의 변화와 맞물린다고 볼 수 있는 점으로 `가상머신`은 낮은 레벨로 내려가고  여러 소프트웨어 패키지 군을 독립적이고 유연하게 구성하고 연계할 수 있는 방식을 채택하고 있는 것으로 판단하여 볼 수 있습니다.

## 도커 이미지의 재사용

코드 / 학습 데이터뿐만 아니라 기존 구성한 도커 이미지의 재사용도 여러의미에서 매우 유의미한 방법입니다.  이미지의 재사용을 통해 얻을 수 있는 장점은 다음과 같습니다.

- 적은 시간으로 이미지를 만들 수 있다.
- 자신만을 위한 이미지 튜닝을 손쉽게 할 수 있다.

처음부터 환경을 구성하는 것도 좋은 생각이지만 안정적인 `수레바퀴`가 있다면 사용해보는 것도 좋겠지요. 기왕이면 official한 이미지를 사용하는 것이 후에 유지보수나 업데이트에도 좋을 것입니다.

R과 관련된 이미지는 다음과 같습니다.

ref: running-shiny-server-in-docker

| Parent image    | Parent size (GB) | Final size (GB) | Bild time (min) |
| --------------- | ---------------- | --------------- | --------------- |
| rhub/r-minimal  | 0.035            | 0.222           | 27.0            |
| rocker/r-base   | 0.761            | 1.050           | 2.9             |
| rocker/r-ubuntu | 0.673            | 1.220           | 3.1             |
| rstudio/r-base  | 0.894            | 1.380           | 3.1             |
| rocker/shiny    | 1.380            | 1.610           | 2.3             |

이중에서  `rocker/shiny`이미지를 사용하여도 좋을듯합니다.

후에 여러가지 테스트를 해본 후 `arm64`기반 이미지 확장이 필요함을 느끼게 되었습니다. 

결론을 말씀드리자면 빠른 시간내 원하는 목적을 이루고자 한다면 이미지 재사용은 필수가 될것입니다.

환경을 구성하는데에 걸리는 시간도 무시할 수 없기 때문입니다. 


### 이미지의 구성

- bit-server-base : 기본 서버 및 라이브러리와 OS기반 패키지를 포함합니다.
- bit-server : bit-server-base를 확장하여 추가적인 패키지를 확장합니다.


## 무엇을 하기 위해서 인가?

이쪽분야에 접근하다보니 다음과 같은 요구사항이 발생하였습니다.

- 업무 환경이 항상 동일하지 않다.
- 작업하던 환경이 유지되면 좋겠다.
- 배포와 테스트 사이클이 빨랐으면 좋겠다.
- 사소한 변경으로 도커 이미지 생성을 피하고 싶다.
- 환경과 코드가 통합되었으면 좋겠다.
- 환경을 세팅하는 방식을 `OS마다` 설명하는 부분을 줄이고 싶다.

## 저장소 자체가 개발 환경이 된다

배포환경과 작업환경을 통합하게되면

- `협업 환경` 구성이 용이하게 됩니다.
- 본연의 업무에 집중할 수 있게 됩니다.

## 어디에 활용하면 좋을까 ?

- 규모가 있는 어플리케이션 패키지 개발 & 배포
- 실습이 용이한 교육환경의 구축
- 환경 세팅을 최소화한 협업 개발환경의 구성

## bit-server

환경을 재구성하는 방법은 앞서 소개한 것과 같이 `가상환경`으로도 충분히 극복할 수가 있습니다. 하지만 소프트웨어의 규모거 더 커지거나 추가 환경을 단일머신에 활용하려다보면 또다른 충돌이 일어나게 됩니다. 대표적인 것으로는 `데이터베이스`, `웹서버`등의 솔류션이라고 할 수 있습니다.

이미 훌륭한 환경이 구성되어있어 어떤 컨테이너를 어떻게 조합하느냐의 문제만 남아있습니다.  여기서 소개하고 싶은 내용은 컨테이너 조합에 대한 부분을 넘어서 `개발 환경`이 곧 `배포 환경`될 수 있도록 구성하고하 하는데 그 의의가 있습니다.

### 포함하고 있는 환경

- nodejs / php / apache2 / ssh / mysql(mariadb)
- shiny-server / R and R package / rstudio-server
- qurto / tex / vim
- python3 / shinylive

## Docker Desktop 설치하기

`Docker Desktop`은 windows / mac OS 환경에서 완벽하게 동작합니다.  docker desktop이 있으면 상태나 컨테이너 연결을 빠르고 쉽게 접근할 수 있습니다.  특히 이미지를 실행하여 컨테이너화 할 때 오류등을 찾아낼 때 유용하게 사용할 수 있습니다.

 아래 링크를 통해 다운로드 하고 설치를 진행합니다.

```
https://docs.docker.com/desktop/install/mac-install/
https://docs.docker.com/desktop/install/windows-install/
```

`windows os`의 경우 `wsl2`기반으로 운용이 되기 때문에 해당 환경을 반드시 구성하여야 합니다.

### Docker 사용시 고려사항

여러개의 OS환경을 동시에 운용할 수 있는 장점이 있는 반면 머신의 리소스를 많이 사용하게 되므로(특히 메모리), 도커 인스턴스의 자원에 대한 설정등을 필요한 만큼 할당하여 사용하도록 관리하는 것이 필요하다는 것을 기억해두시면 좋습니다.

```
Runtime options with Memory, CPUs, and GPUs
https://docs.docker.com/config/containers/resource_constraints/
```

#### windows에서 wsl2연동 후 메모리 제한하기

```
code %USERPROFILE%\.wslconfig 
```

`.wslconfig`

```
[wsl2]

# Limits VM memory to use no more than 8 GB, this can be set as whole numbers using GB or MB
memory=4GB
# Makes the WSL 2 VM use two virtual processors
processors=4 
```

## bit-server 내려받기

### git clone bit-server

```
git clone https://github.com/joygram/bit-server.git
```

### docker run

```
cd bit-server/docker 
./run_docker.[cmd,sh]
```

## 개발환경(workspace)

### workspace 흐름

```mermaid
sequenceDiagram
bit_server -->> bit_server : git clone
bit_server -->> docker : docker run & live update
workspace -->> docker : run 
workspace -->> workspace : authoring with vscode
docker -->> web_browser : execute
```

### workspace 구성

작업하고자 하는 `git`프로젝트의 저장소를 `workspace`아래 연결합니다.

```
cd workspace 
git clone 주소 
git clone 주소
```

### 개발환경 (VsCode를 활용)

visual studio code는 개발환경이 `원격`,`로컬`유무에 따라 내부 확장(extension)을 설치하는 방식이 달라집니다. 특히 원격 개발을 진행할 때에는 자체적으로 visual studio code 서버를 구동 시키며 `ssh` 포트 포워딩을 자동으로 수행하여 줍니다.

- VsCode로 `ssh`를 통해 도커환경에 접속하여 개발을 진행

```
ssh shiny@localhost -p 4444
```

로컬에 환경이 구성되어 있다면 기존 환경을 그대로 활용하는 방안도 있습니다. 다만, 로컬 환경은 각자 세팅이나 OS설정에 따라 달라질 수 있으므로 실행 결과가 불일치 할 수 있습니다.

### 웹서비스와 통합

웹서비스와 shiny-server서비스를 `같은 포트`로 서비스하고자 하는 경우 `proxy`와 `rewrite`모듈을 활용하여 연동하여 주도록 합니다.

이렇게 하였을 때 `여러종류의 웹서비스`를 하나의 통합된 사이트를 통해 연결할 수 있습니다.

#### 웹서버 디렉토리

기본 웹디렉토리는 `workspace/html` 이하에 두도록 하였습니다. 필요한 html파일이 있다면 그곳에 배포하여 주시면 됩니다. 그외 접근하고자 하는 설정이 있다면 `apache2`설정을 추가하여 설정하여 주시면 됩니다.

## 환경 커스텀

bit-server의 목표중 하나는 도커이미지 빌드를 최소화한 유연한 개발환경의 확보입니다. 이것을 위해 서버 설정, 개발환경의 설정을 커스텀할 수 있는 여지를 만들었습니다.

### 도커환경 커스텀하기 (env)

`env.[cmd,sh]`를 통해 도커 실행 스크립트를 변경하지 않고 컴퓨팅 환경에 맞추어 실행 환경을 구성할 수 있도록 하였습니다. 가장 빈번하게 변경되는 이슈가 `네트워크 포트`와 `컨테이너 이름`이 될 수 있기에 해당 부분에 대해 설정을 반영하였습니다.

```
workspace/conf/
	env.sh 
	env.cmd
```

`env.sh`

```
# env.sh
# override for your environment 
#WEB_PORT=9090
#export WEB_PORT

#SSH_PORT=4444
#export SSH_PORT

#SHINY_PORT=3939
#export SHINY_PORT

#SSL_PORT=8443
#export SSL_PORT

#CONTAINER_NAME=bit-server
#export CONTAINER_NAME
```

### 서버 환경 커스텀

서버 환경 설정을 변경하여 커스텀하고 싶은 경우 서버 설정을 오버라이드 할 수 있도록 기존 설정을 `workspace`에 복사후 변경을 하시면 됩니다.

#### workspace에 커스텀 설정을 추가합니다.

현재는 shiny-server와 apache2 서버의 커스텀 설정을 설정할 수 있도록 하였습니다.

workspcae가 배포환경이라면 배포환경의 scripts/apache2나 scripts/shiny-server의 파일을 workspace/conf/쪽에 복사한 후  설정을 변경하시면 됩니다.

```
bit-server/workspace/conf/
	shiny-server/
	apache2/
```

## 같은 환경 다른 프로젝트

이제까지 느낌을 보시면서 느끼신 바와 같이 하나의 환경에 `도커 이미지` 재빌드하지 않고 다른 프로젝트의 확장도 고려하여 사용할 수 있도록 `커스텀`의 여지를 만들어 두었습니다.
여러개의 bit-server를 `클론`하고 각각 다른 `커스텀 설정`을 추가한다면 유연하게 확장할 수 있을 수 있습니다. 확장하기 위해 추가적인 컨셉을 도입할 여지는 있습니다.

```mermaid
stateDiagram 
bit_server --> bit_server_a 
bit_server --> bit_server_b
bit_server_a --> custom_env_a
bit_server_b --> custom_env_b
custom_env_a --> workspace_project_a  
custom_env_b --> workspace_project_b 
```

## bit-server 이해하기

### bit-server의 구성

bit-server 프로젝트는 `Docker`를 생성/실행/갱신을 하기 위한 부분과 `라이브 패치 및 실행`을 담당하는 부분 `workspace`를 연결하고 커스텀할 수 있는 부분으로 구성되어 있습니다.

```
docker/ : 도커 이미지 및 실행 스크립드들을 포함 
scripts/ : 도커 개발 환경의 서비스 실행 및 이미지 저장소 업데이트 
workspace/ : 개발환경을 구축할 수 있는 entry point 
```

### 도커 환경 `라이브 패치`가 이루어진다.

`bit-server` git은 도커 이미지를 다시 빌드하지 않고 스크립트 및 설정을 `라이브 패치`가 가능하도록 구성하였습니다.

저장소에 커밋을 하면 재시작시 라이브 패치를 진행합니다.  즉, 최신버젼의 서버 설정 등이 있다면 자연스럽게 반영이 되겠지요.  물론 도커이미지에 포함된 라이브러리등의 변경이 이루어졌을 경우 최신버젼을 내려받아야만 하는 경우도 발생할 것입니다.

간단한 스크립트 패치나 서버의 시작 도커 컨테이너에 추가적인(임시적인) 라이브러리 포함 등이 해당할 것입니다.

### bit-server 라이브 패치 및 업데이트 흐름

```mermaid
stateDiagram
bit_server_git --> bit_server : git clone
bit_server --> workspace
projects --> workspace : clone project
bit_server_git --> bit_server : live_update
bit_server --> docker : run_bit_server
workspace --> docker : mount
docker --> broswer : live result 
editor --> workspace : authoring
```

### shiny-server와의 통합은 어떻게 했나

기본 설정은 다음과 같이 되어 있으며 `/shiny/` 로 접근하면 `shiny-server`로 pass해주도록 합니다. shinyApp의 경우 `websocket`을 사용하므로 관련 설정을 함께 포함하여 주어야 합니다.  그외 여러가지 웹서비스와 통합이 가능하도록 설정을 추가하시면 됩니다.

```apache
<VirtualHost *:80>
    DocumentRoot /home/bit-server/workspace/html
    ProxyRequests Off
    ProxyPreserveHost On

    # shiny app redirect 
    RewriteEngine on
    RewriteCond %{HTTP:Upgrade} =websocket
    RewriteRule /shiny/(.*) ws://localhost:3838/$1 [P,L]
    RewriteCond %{HTTP:Upgrade} !=websocket
    RewriteRule /shiny/(.*) http://localhost:3838/$1 [P,L]
    ProxyPass /shiny/ http://localhost:3838/
    ProxyPassReverse /shiny/ http://localhost:3838/
    ProxyRequests Off
</VirtualHost>
```

## Reference

```
Running Shiny Server in Docker
https://www.r-bloggers.com/2021/06/running-shiny-server-in-docker/

Shiny on Google Cloud Run - Scale-to-Zero R Web Apps
https://code.markedmondson.me/shiny-cloudrun/

Docker docs 
https://docs.docker.com

Quarto
https://quarto.org
```
