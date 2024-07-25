FROM zmkfirmware/zmk-build-arm:stable

ARG WEST_CONFIG=west.yml

WORKDIR /root
COPY ${WEST_CONFIG} config/west.yml

RUN west init --local config
RUN west update
RUN west zephyr-export

COPY scripts/* scripts/
RUN chmod +x scripts/*

COPY common/* config/

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
COPY boards/arch36/arch36.conf config/

# Chocofi
COPY boards/chocofi config/boards/shields/chocofi
COPY boards/chocofi/chocofi.conf config/

# Corneish-Zen
COPY boards/corneish-zen/corneish_zen* config/

# Waterfowl
COPY boards/waterfowl config/boards/shields/waterfowl
COPY boards/waterfowl/waterfowl.conf config/

CMD ./scripts/build_${BOARD}
