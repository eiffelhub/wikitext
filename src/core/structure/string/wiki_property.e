note
	description: "Summary description for {WIKI_PROPERTY}."
	date: "$Date: 2014-12-02 11:11:23 +0100 (mar., 02 déc. 2014) $"
	revision: "$Revision: 96211 $"

class
	WIKI_PROPERTY

inherit
	WIKI_STRING_ITEM

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
			-- [[Property:name|value]]
			-- [[Category:name]]
		require
			valid_wiki_property: s.count > 0
			starts_with_double_bracket: s.starts_with ("[[")
			ends_with_double_bracket: s.ends_with ("]]")
		local
			i, p, n: INTEGER
			t,l_title: detachable STRING
			in_link: INTEGER -- depth
			l_lower_name: like name
		do
			from
				n := s.count
				p := 1 + 2 -- skip "[["
				i := p
			until
				p > n or not is_valid_wiki_name_character (s.item (p))
			loop
				p := p + 1
			end
			name := s.substring (i, p - 1)
			name.left_adjust
			name.right_adjust
			if p < n then
				from
					create t.make_empty
				until
					p > n - 2
				loop
					if in_link > 0 then
						if s[p] = ']' and then safe_character (s, p + 1) = ']' then
							in_link := in_link - 1
							p := p + 1
							t.extend (']')
							t.extend (']')
						else
							t.extend (s[p])
						end
					else
						inspect s[p]
						when '|' then
							if l_title = Void or else l_title.is_empty then
								l_title := t
							else
								add_parameter (l_title)
								l_title := t
							end
							create t.make_empty
						when '[' then
							t.extend ('[')
							if safe_character (s, p + 1) = '[' then
								in_link := in_link + 1
								p := p + 1
								t.extend ('[')
							end
						else
							t.extend (s[p])
						end
					end
					p := p + 1
				end
				if t.is_empty then
					if l_title = Void or else l_title.is_empty then
						text := wiki_raw_string (name)
					else
						text := wiki_raw_string (l_title)
					end
				else
					if l_title /= Void then
						add_parameter (l_title)
					end
					text := wiki_raw_string (t)
				end
			else
				text := wiki_raw_string (name)
			end
			l_lower_name := name.as_lower
			i := l_lower_name.index_of (':', 1)
			if i > 0 then
				sub_type := l_lower_name.head (i - 1)
				name.remove_head (i)
			else
				sub_type := "property"
			end
		end

feature -- Access

	sub_type: STRING

	name: STRING

	text: WIKI_RAW_STRING

	parameters: detachable ARRAYED_LIST [READABLE_STRING_8]

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := name.is_empty and text.is_empty
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := name + " {" + generator + "}"
		end

feature -- Element change

	add_parameter (p: READABLE_STRING_8)
		local
			lst: like parameters
		do
			lst := parameters
			if lst = Void then
				create lst.make (1)
				parameters := lst
			end
			lst.force (p)
		ensure
			parameters /= Void
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_property (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
