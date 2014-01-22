module HashDiff


	# options
	#
	# * :ignore_array_ordering
	# if true, array sorting does not matter
	#
	# * :ignored_keys
	# an array of keys that can be ignored
	# 
	def self.same?(left, right, options={})
#		puts "same?:#{left}, #{right}, #{options}"
		return true if left == right # cheap early exit
		return false unless left.class == right.class
		case left
		when Hash
			return same_hash? left,right,options
		when Array
			return same_array? left,right,options
		else
			return left == right
		end
	end

	def self.same_hash?(left,right,options = {})
		ignored_keys = options[:ignored_keys] || []
		ignored_keys.map!{|t| t.to_sym}
		(left.keys + right.keys).uniq.each do |key|
			next if ignored_keys.member? key.to_sym
			# check if keys exist
			if left.key?(key) && right.key?(key)
				return false unless same? left[key],right[key],options
			else
				# we miss a non ignorable key. return false
				puts "key #{key} missing in:#{left.key?(key) ? right : left }"
				return false
			end
		end
	end

	def self.same_array?(left,right,options) 
		return false if left.size != right.size # cheap check
		ignore_array_ordering = options[:ignore_array_ordering] || false
		if ignore_array_ordering
			left = left.sort_by{|t| t.to_s}
			right = right.sort_by{|t| t.to_s}
		end
		return true if left == right # early exit
		left.size.times do |t|
			return false unless same? left[t],right[t],options
		end
	end

end
