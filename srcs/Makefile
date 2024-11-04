# Build and run nginx container
all:
	sudo docker build -t nginx ./requirements/nginx/
	sudo docker run -it nginx

# Stop and remove container
stop:
	sudo docker stop nginx-container
	sudo docker rm nginx-container

# Remove image
clean:
	sudo docker rmi nginx

# Full cleanup
fclean: stop clean

# Rebuild everything
re: fclean all

.PHONY: all stop clean fclean re