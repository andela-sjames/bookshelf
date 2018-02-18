build-app:
	docker build --tag bookshelfapp:latest .

run-app:
	@eval docker run -v $$(pwd):/app -it -p 8000:8000 bookshelfapp:latest 

stop-app:
	@eval docker stop $$(docker ps -a -q)
