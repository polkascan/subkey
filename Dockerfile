# ===== START FIRST STAGE ======
FROM phusion/baseimage:0.11 as builder
LABEL maintainer "support@polkasource.com"
LABEL description="Large image for building the binary."

ARG PROFILE=release
WORKDIR /rustbuilder
COPY . /rustbuilder

# PREPARE OPERATING SYSTEM & BUILDING ENVIRONMENT
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y cmake pkg-config libssl-dev git clang libclang-dev 
	
# CHECKOUT GIT SUBMODULES
RUN git submodule update --init --recursive
	
# UPDATE RUST DEPENDENCIES
ENV RUSTUP_HOME "/rustbuilder/.rustup"
ENV CARGO_HOME "/rustbuilder/.cargo"
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH "$PATH:/rustbuilder/.cargo/bin"
RUN rustup update nightly
RUN RUSTUP_TOOLCHAIN=stable cargo install --git https://github.com/alexcrichton/wasm-gc

# BUILD RUNTIME AND BINARY
RUN rustup target add wasm32-unknown-unknown --toolchain nightly
RUN cd /rustbuilder/substrate && RUSTUP_TOOLCHAIN=stable cargo build -p subkey --$PROFILE
# ===== END FIRST STAGE ======

# ===== START SECOND STAGE ======
FROM phusion/baseimage:0.11
LABEL maintainer "support@polkasource.com"
LABEL description="Small image with the binary."
ARG PROFILE=release
COPY --from=builder /rustbuilder/substrate/target/$PROFILE/subkey /usr/local/bin

# REMOVE & CLEANUP
RUN mv /usr/share/ca* /tmp && \
	rm -rf /usr/share/*  && \
	mv /tmp/ca-certificates /usr/share/ && \
	rm -rf /usr/lib/python*
RUN	rm -rf /usr/bin /usr/sbin

# FINAL PREPARATIONS
WORKDIR /usr/local/bin
ENTRYPOINT ["subkey"]
CMD ["--help"]
# ===== END SECOND STAGE ======