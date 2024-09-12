LIB_NAME = libmx.a

SRC_DIR = src
OBJ_DIR = obj
INC_DIR = inc

SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

INC_FILES = $(wildcard $(INC_DIR)/*.h)

COMPILER = clang
COMP_FLAGS = -std=c11 -Wall -Wextra -Werror -Wpedantic -g

ARCHIVER = ar
ARCH_FLAGS = rcs

MKDIR_CMD = mkdir -p
RM_CMD = rm -rf

.PHONY: all uninstall clean reinstall

build: $(LIB_NAME)

$(LIB_NAME): $(OBJ_FILES)
	$(ARCHIVER) $(ARCH_FLAGS) $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INC_FILES) | $(OBJ_DIR)
	$(COMPILER) $(COMP_FLAGS) -c $< -o $@ -I $(INC_DIR)

$(OBJ_DIR):
	$(MKDIR_CMD) $@

clean:
	$(RM_CMD) $(OBJ_DIR)

uninstall: clean
	$(RM_CMD) $(LIB_NAME)

reinstall: uninstall build
