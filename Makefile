.PHONY: help up-dev up-prod down-dev down-prod logs shell-web shell-db ps build

# 기본 명령어 (make만 입력했을 때 실행됨)
help:
	@echo "사용 가능한 명령어 목록:"
	@echo "  make up-dev    - [로컬/개발용] 도커 컨테이너 백그라운드 실행 (override 파일 자동 적용)"
	@echo "  make up-prod   - [운영용] 라이트세일 서버용 도커 컨테이너 실행 (prod 파일 적용)"
	@echo "  make down-dev  - [로컬/개발용] 도커 컨테이너 종료 및 삭제"
	@echo "  make down-prod - [운영용] 도커 컨테이너 종료 및 삭제"
	@echo "  make logs      - 실행 중인 컨테이너의 실시간 로그 보기"
	@echo "  make shell-web - 웹(PHP/Apache) 컨테이너 내부 쉘로 접속"
	@echo "  make shell-db  - DB(MariaDB) 컨테이너 내부 쉘로 접속"
	@echo "  make ps        - 현재 실행 중인 컨테이너 상태 확인"
	@echo "  make build     - 웹 컨테이너 이미지 다시 빌드"

up-dev:
	docker compose --env-file .env.dev up -d

up-prod:
	docker compose --env-file .env.prod -f docker-compose.yml -f docker-compose.prod.yml up -d

down-dev:
	docker compose --env-file .env.dev down

down-prod:
	docker compose --env-file .env.prod -f docker-compose.yml -f docker-compose.prod.yml down

logs:
	docker compose logs -f web

build:
	docker compose build web

# 웹 컨테이너 접속 (패키지 설치나 파일 권한 확인할 때 유용)
shell-web:
	docker exec --user www-data -it apm-web bash

# DB 컨테이너 접속 (직접 SQL 명령어를 쳐야 할 때 유용)
shell-db:
	docker exec -it apm-db bash

# 컨테이너 상태 확인
ps:
	docker compose ps