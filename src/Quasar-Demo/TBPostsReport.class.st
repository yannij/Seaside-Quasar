Class {
	#name : 'TBPostsReport',
	#superclass : 'MDQMarkupTable',
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'instance creation' }
TBPostsReport class >> filteredDescriptionsFrom: aBlogPost [
	"Filter only some descriptions for the report columns."

	^ aBlogPost magritteDescription select: [ :each |
		  #( title category date ) includes: each accessor selector ]
]

{ #category : 'instance creation' }
TBPostsReport class >> from: aBlog [
	| allBlogs |

	allBlogs := aBlog allBlogPosts.
	^ self rows: allBlogs description: (self filteredDescriptionsFrom: allBlogs anyOne)
]
