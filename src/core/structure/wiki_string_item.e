note
	description: "Summary description for {WIKI_STRING_ITEM}."
	author: ""
	date: "$Date: 2014-12-02 11:11:23 +0100 (mar., 02 déc. 2014) $"
	revision: "$Revision: 96211 $"

deferred
class
	WIKI_STRING_ITEM

inherit
	WIKI_ITEM

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		deferred
		end

	is_whitespace: BOOLEAN
			-- Is empty or blank text?
		do
				--| Redefined where a string item may be whitespace.
			Result := False
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
