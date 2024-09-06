# Variables
NAME = minitalk
CC = cc
CFLAGS = -Wall -Wextra -Werror -Iinclude
SRC_DIR = src/
BONUS_DIR = src/bonus/
INCLUDE_DIR = include/
OBJ_DIR = obj/

# Source files
SRC_FILES = $(SRC_DIR)client.c $(SRC_DIR)server.c $(SRC_DIR)utils.c
BONUS_FILES = $(BONUS_DIR)client_bonus.c $(BONUS_DIR)server_bonus.c $(BONUS_DIR)utils_bonus.c
HEADER = $(INCLUDE_DIR)minitalk.h
BONUS_HEADER = $(INCLUDE_DIR)minitalk_bonus.h

# Object files
OBJ_FILES = $(SRC_FILES:$(SRC_DIR)%.c=$(OBJ_DIR)%.o)
BONUS_OBJ_FILES = $(BONUS_FILES:$(BONUS_DIR)%.c=$(OBJ_DIR)%.o)

# Executables
CLIENT = client
SERVER = server
CLIENT_BONUS = client_bonus
SERVER_BONUS = server_bonus

# Default target
all: $(NAME)

$(NAME): $(CLIENT) $(SERVER)

# Rules for main executables
$(CLIENT): $(OBJ_DIR)client.o $(OBJ_DIR)utils.o
	$(CC) $(CFLAGS) -o $@ $(OBJ_DIR)client.o $(OBJ_DIR)utils.o

$(SERVER): $(OBJ_DIR)server.o $(OBJ_DIR)utils.o
	$(CC) $(CFLAGS) -o $@ $(OBJ_DIR)server.o $(OBJ_DIR)utils.o

# Rules for bonus executables
bonus: $(CLIENT_BONUS) $(SERVER_BONUS)

$(CLIENT_BONUS): $(OBJ_DIR)client_bonus.o $(OBJ_DIR)utils_bonus.o
	$(CC) $(CFLAGS) -o $@ $(OBJ_DIR)client_bonus.o $(OBJ_DIR)utils_bonus.o

$(SERVER_BONUS): $(OBJ_DIR)server_bonus.o $(OBJ_DIR)utils_bonus.o
	$(CC) $(CFLAGS) -o $@ $(OBJ_DIR)server_bonus.o $(OBJ_DIR)utils_bonus.o

# Compilation of object files
$(OBJ_DIR)%.o: $(SRC_DIR)%.c $(HEADER)
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)%.o: $(BONUS_DIR)%.c $(BONUS_HEADER)
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up object files and executables
clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(CLIENT) $(SERVER) $(CLIENT_BONUS) $(SERVER_BONUS)

# Rebuild everything
re: fclean all

# Declare phony targets
.PHONY: all clean fclean re bonus