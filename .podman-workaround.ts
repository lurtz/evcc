// Dockerfile specifies to copy hidden *.ts and *.mts files.
// The only currently present files matching this pattern are in the
// .storybook directory, which is excluded via .dockerignore.
// I decided against modifying the Dockerfile,
// because evcc might add files like that again and then I might have a harder to debug issue.
