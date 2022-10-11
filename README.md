

# OS와 무관한 데이터 과학 개발 환경 구성



## 컨테이너 기반 환경 구성 

```
Don't reinvent the wheel
```

여러 선배님들과 엔니지어 분들이 이 원칙을  잘 준수하여 준 덕분에 소프트웨어의 모듈화, 패키지화는 잘 실현이 되었습니다. 

### 패키지 매니져 

하지만 그로 인한 부작용 역시 있었으니 `dll`, `패키지`가 무수히 많아지고 라이프 사이클이 길어지는 대신 다양한 버젼간의 충돌이 발생하게 되었습니다.

그것을 해소하기 위해 버젼에 대한 의존성과 패키지의 관리를 위한 여러 노력들이 다양한 프로그래밍 환경에 적용되기 시작하였습니다.

### 가상환경 

다양한 환경의 의존성이 있는 프로젝트를 여러개를 진행하는 경우 패키지 매니져를 통해서도 해결할 수 없는 경우가 종종 발생하기 시작하였고 특히, 데이터 과학 분야 쪽은 사용하는 프로젝트 기반의 세대와 발전속도가 비약적으로 증가함에 따라 또다른 방식의 해결방식이 필요하게 되었습니다. 

우리가 자주 사용하는  `conda`, `venv`, `renv` 와 같은 독립환경 구성등이 그 예 라고 할 수 있습니다. 

### 컨테이너 기반 환경 구성 

컨테디너 기반 환경구성의 필요성이 대두된 것은 어제 오늘 일은 아닙니다. 이전에는 `가상머신` 기반의 구성으로 os기반을 확장하였으나 그것이 점차 `컨테이너 기반 방식`으로 변화하게 됩니다. 컴퓨팅 환경의 변화와 맞물린다고 볼 수 있는 점으로 `가상머신`은 낮은 레벨로 내려가고  여러 소프트웨어 패키지 군을 독립적이고 유연하게 구성하고 연계할 수 있는 방식을 채택하고 있는 것으로 판단하여 볼 수 있습니다.  



## bit-server

software 개발환경의 복잡도가 올라감에 따라서 환경의 독립성을 유지 시키면서 개발하려는 구성이

프로그래밍 언어 전반에 걸쳐 정착 단계에 있다고 보여진다.

conda, renv 등이 그 대표적인 것이 되겠다.

심플한 애플리케이션을 개발하고 테스트하고 배포하는 환경은 이미 완벽하리 만큼 잘 구성되어 있다.

하지만 좀 더 규모가 있는 애플리케이션을 개발하고 배포하고자 하거나 독립적인 환경을 구성하고자 할 때는

현재 shiny-app이 가진 특성상 환경 구성을 계획하는데 어려움을 겪는 사례가 종종 보인다.



### 여러 클라이언트 장비를 가지고 접근 개발해야 하는 경우

클라이언트 OS가 각각 달라지는 경우 매번 라이브러리 환경을 구성하고 필요한 툴을 설치하는 과정이 필요하게 된다.

os별로 환경을 구성하는 것도 불편하다.

작업 머신이 노트북 / 데스크톱으로 자주 바뀌는 환경이라면 더욱 그러할 것이다.

도커와 vscode, github을 이용한 구성

- 도커 개발 환경 구성

  - docker desktop 설치 (mac / win)
- github에서 개발환경 클론
- shiny-server 기반 도커 환경
- github에 workspace 만들기
- vscode를 통한 원격환경 구성

  - github계정으로 놀아보자
  - vscode web (github과의 궁합) 확인
- 원격서버에 배포
- 로컬 환경에서 사용
- os와 무관한 원격 개발환경

언제 좋을까?

통합환경 구성 패키지 설치등이 복잡할 때

복잡한 통계 패키지 환경 구성이 필요할 때

개발한 패키지를 컨테이너 단위로 배포하고자 할때

## bit-server 내려받기

```
git clone https://github.com/joygram/bit-server.git
```

포함하고 있는 환경

- nodejs / php / mysql(mariadb) / shiny-server / R and R package / qurto / tex / apache2 / vim / python3 / shinylive

## 프로젝트 연결하기

작업하고자 하는 `git`프로젝트의 저장소와 token 설정을 한다.

```
repository git주소 
respsitory git주소
```



## 저장소 자체가 개발 환경이 된다 



저장소가 없으면 clone 있으면 sync를 수행한다.

```mermaid
sequenceDiagram
host -->> workspace : clone
bit_server -->> workspace : read & service
workspace --> docker : run
```



### 포트 개방 :

```
3838 -> 3939 
80 -> 8080
443 -> 8443
22 -> 2222
```

### SSH 연결 

```
ssh shiny@localhost -p 2222
```

```
conf/넣어 오버라이드 하거나 한다. 

RUN install.r shiny forecast jsonlite ggplot2 htmltools
```

```
by default, renv creates project libraries that cannot be moved to a different machine or even user account, due to its reliance on a global cache that sits outside of the project directory. This is exactly the behavior that you want if you're doing local development, but it is problematic for your scenario.

Fortunately, renv includes a solution for this problem. On the development machine, inside the project, call renv::isolate() and this will remove the reliance on the cache. You should then copy the entire project directory, including the project-specific .Rprofile, to the server.

Hope that helps.

Eventually what I did instead of actually copying the contents of the renv directory from the dev to prod server was to log into the production server, get into the app's directory. Then run R, and use renv::restore and then renv::isolate. I find it to be somewhat easier and hence preferable than copying directories from one location to the other.
```



의존성 

```dockerfile
RUN install.r shiny forecast jsonlite ggplot2 htmltools
```

```
install.r 
```

## 컨테이너 

생성한 컨테이너를 지우지만 않으면 기본 환경 구성은 유지가 된다. 

따로 생성한 컨테이너를 보관하고 싶은 경우 

```
docker commit 
```

구성한 이미지를 올려서 배포 할 수 있다 



## Reference 

```
Running Shiny Server in Docker
https://www.r-bloggers.com/2021/06/running-shiny-server-in-docker/
https://github.com/analythium/covidapp-shiny

Running Shiny Server in Docker
https://www.r-bloggers.com/2021/06/running-shiny-server-in-docker/

Shiny on Google Cloud Run - Scale-to-Zero R Web Apps
https://code.markedmondson.me/shiny-cloudrun/
```



```
As you've found out, you are stuck once the package is loaded. R doesn't behave well when unloading a pkg that another pkg uses directly.

I'm also guessing that you can't use callr::r to do calculations. This would launch a new process and you'd get control over which pkgs are loaded. But would only work as a on off calculator, not an interactive R session.

You said the Shiny Server is run by the university. I'm wondering if you can ask the admin to add this line to the config: (replace shiny with whichever user they are currently using)

location /zeolite/rpauloo  {
  run_as :HOME_USER: shiny;
}
Docs: https://support.rstudio.com/hc/en-us/articles/214771447-Shiny-Server-Administrator-s-Guide#run_as

This should run the apps in your folder under your user name, which should then load your ~/.Rprofile, which would allow you to set the appropriate .libPaths().

It is worth an ask to your admin. You're not asking for sudo privileges, just your existing user privileges.

If they already do this, make sure you have a ~/.Rprofile that adds your correct .libPath().
```

