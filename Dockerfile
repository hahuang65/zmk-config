FROM zmkfirmware/zmk-build-arm:3.2

WORKDIR /root
COPY west.yml config/west.yml

RUN west init --local config
RUN west update
RUN west zephyr-export

COPY scripts/* scripts/
RUN chmod +x scripts/*

# nice!60
COPY boards/nice60/nice60* config/

# Polarity Works BT60
COPY boards/bt60 config/boards/arm/bt60

# ErgoTravel
COPY boards/ergotravel config/boards/shields/ergotravel

# Lily58
COPY boards/lily58/lily58* config/

# Arch36
COPY boards/arch36 config/boards/shields/arch36

# Chocofi
COPY boards/chocofi config/boards/shields/chocofi

CMD ./scripts/build_${BOARD}
