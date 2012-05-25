note
	description: "Summary description for {WIKI_LINE_SEPARATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_LINE_SEPARATOR

inherit
	WIKI_ITEM

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.process_line_separator (Current)
		end

note
	copyright: "2011-2012, Jocelyn Fiat"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
