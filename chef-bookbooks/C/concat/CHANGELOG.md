# 0.3.0
- extended concat_fragment to accept templates or cookbook files

# 0.2.1
- uses the right combination of provides and resource_name to
  work on Chef 12.3

# 0.2.0
- adds :delete for concat which removes target file and fragment
	directory
- adds :delete for concat_fragment: removes fragment from fragment
	directory
- fixed updated_by_last_action calls to be accurate
- list supported platforms in cookbook metadata
- refactored tests and added additional tests for :delete

# 0.1.0

Initial release of **concat**
- `:create` for **concat_fragment**
- `:create` for **concat**
