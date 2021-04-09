FROM codercom/code-server:3.9.3


RUN code-server --install-extension xabikos.javascriptsnippets \
    && code-server --install-extension msjsdiag.debugger-for-chrome \
    && code-server --install-extension dbaeumer.vscode-eslint \
    && code-server --install-extension coenraads.bracket-pair-colorizer \
    && code-server --install-extension formulahendry.auto-rename-tag \    
    && code-server --install-extension christian-kohler.path-intellisense \    
    && code-server --install-extension auchenberg.vscode-browser-preview \    
    && code-server --install-extension vscode-icons-team.vscode-icons \    
    && code-server --install-extension ritwickdey.liveserver \
    && code-server --install-extension mubaidr.vuejs-extension-pack \
    # sudo apt-get update && \
    # sudo apt-get install -y git sudo && \
    # mkdir -p /tmp/oop-project-build/ && cd /tmp/oop-project-build/  && \
    # git clone https://github.com/UAws/OOP-Project.git && \
    # cd OOP-Project/script/ && \
    # sed -i 's/exit/echo/g' ./build_dependencies.sh && \
    # ./build_dependencies.sh && rm -rf /tmp/oop-project-build/ && \
    # install plugins
    && rm -rf /home/coder/.local/share/code-server/settings.json /home/coder/.local/share/code-server/User/settings.json \
    && sudo chown coder:coder -R /home/coder/project

COPY .config/code-server/config.yaml /home/coder/.config/code-server/config.yaml 
COPY ./settings.json /home/coder/.local/share/code-server/settings.json
COPY ./settings.json /home/coder/.local/share/code-server/User/settings.json
COPY ./settings.json /home/coder/.vscode/settings.json

RUN sudo chown -R 1000:1000 /home/coder/.local/share/code-server



EXPOSE 8080
# This way, if someone sets $DOCKER_USER, docker-exec will still work as
# the uid will remain the same. note: only relevant if -u isn't passed to
# docker-run.
USER 1000
WORKDIR /home/coder
ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
# testing：
# docker run -it --name code-server -p 127.0.0.1:8080:8080 \
#   -v "`pwd`/.config:/home/coder/.config" \
#   -e "DOCKER_USER=$USER" \
#    akide/oop-project-code-server-docker:v1.0.0


# docker run -it --name code-server -p 127.0.0.1:8080:8080 \
#   -e "DOCKER_USER=$USER" \
#    akide/oop-project-code-server-docker:v1.0.0