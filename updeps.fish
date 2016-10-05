function updeps --description 'Commit Cargo.lock after an cargo update (for Rust projects)'
	git commit Cargo.lock -m"Update dependencies" $argv;
end
