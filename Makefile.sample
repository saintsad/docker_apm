# ==========================================
# Docker Compose 모듈 관리 Makefile
# ==========================================

# 기본적으로 무조건 실행되는 베이스 파일
BASE_FILE = docker-compose.yml

# 사용자가 입력한 M="db redis" 등의 변수를 받아 -f 인자로 변환
COMPOSE_ARGS = -f $(BASE_FILE)
ifdef M
    # 예: M="db redis" -> -f docker-compose.db.yml -f docker-compose.redis.yml
    COMPOSE_ARGS += $(foreach mod,$(M),-f docker-compose.$(mod).yml)
endif

# down 할 때는 고아(orphan) 컨테이너가 발생하지 않도록 디렉토리 내 모든 yml을 묶어서 종료
ALL_YML = $(wildcard docker-compose*.yml)
DOWN_ARGS = $(foreach yml,$(ALL_YML),-f $(yml))

.PHONY: up down restart ps logs

# 컨테이너 실행
up:
	@echo "🚀 다음 서비스들을 시작합니다: base $(M)"
	docker compose $(COMPOSE_ARGS) up -d

# 컨테이너 종료 및 정리
down:
	@echo "🛑 모든 서비스를 종료하고 컨테이너를 삭제합니다..."
	docker compose $(DOWN_ARGS) down --remove-orphans

# 재시작
restart: down up

# 상태 확인
ps:
	docker compose $(DOWN_ARGS) ps

# 전체 로그 확인
logs:
	docker compose $(DOWN_ARGS) logs -f