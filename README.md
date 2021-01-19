
## usersテーブル
| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| nickname     | string | null: false |
| email        | string | null: false |
| password     | string | null: false |
| introduction | text   |             |

### Association
has_many :cafes
<!--能動的関係-->
has_many :relationships, dependent: :destroy
has_many :followings, through: :relationships, source: :follow
<!--受動的関係-->
has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
has_many :followers, through: :reverse_of_relationships, source: :user

has_many :favorites, dependent: :destroy
has_many :comments
<!--通知をした-->
has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
<!--通知を受けた-->
has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy
has_many :lists, dependent: :destroy

## cafesテーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| name       | string     | null: false                    |
| text       | text       | null: false                    |
| purpose_id | integer    | null: false                    |
| place      | string     | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association
belongs_to :user
has_many :favorites, dependent: :destroy 
has_many :comments
has_many :notifications, dependent: :destroy
has_many :lists, dependent: :destroy

## relationshipsテーブル
| Column     | Type       | Options                                        |
| ---------- | ---------- | ---------------------------------------------- |
| user       | references | null: false, foreign_key: true                 |
| follow     | references | null: false, foreign_key: { to_table: :users } |

### Association
belongs_to :user
belongs_to :follow, class_name: 'User'

## favoritesテーブル
| Column | Type       | Options                        |
| -------| ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| cafe   | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :post

## commentsテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text       | null, false                    |
| user    | references | null: false, foreign_key: true |
| cafe    | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :cafe
has_many :notifications, dependent: :destroy

## notificationsテーブル
| Column  | Type       | Options                                       |
| ------- | ---------- | --------------------------------------------- |
| visitor | references | null: false, foreign_key:{ to_table: :users } |
| visited | references | null: false, foreign_key:{ to_table: :users } |
| cafe    | references | foreign_key: true                             |
| comment | references | foreign_key: true                             |
| action  | string     | null: false                                   |
| checked | boolean    | null: false, default: false                   |

### Association
  default_scope -> { order(created_at: :desc) }
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true
  belongs_to :cafe, optional: true
  belongs_to :comment, optional: true

## listsテーブル
| Column    | Type       | Options                                        |
| --------- | ---------- | ---------------------------------------------- |
| user      | references | null: false, foreign_key: true                 |
| cafe      | references | null: false, foreign_key: true                 |
| form_user | references | null: false, foreign_key: { to_table: :users } |

### Association
belongs_to :user
belongs_to :cafe
belongs_to :form_user, class_name: 'User'