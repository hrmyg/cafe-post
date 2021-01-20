class Purpose < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '食事する、コーヒー等を飲む' },
    { id: 3, name: '人と会う、話す' },
    { id: 4, name: '勉強、仕事' },
    { id: 5, name: '読書' },
    { id: 6, name: '考え事' },
    { id: 7, name: '暇つぶし（待ち合わせまで等）' },
    { id: 8, name: '目的はなくのんびりする' },
    { id: 9, name: 'デート' },
    { id: 10, name: 'インスタ映えを狙って' },
    { id: 11, name: 'その他'}
  ]

  include ActiveHash::Associations
  has_many :posts
end
