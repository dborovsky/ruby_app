require_relative '../log_parser'

describe LogParser do
  let(:parse_result) do
    [
      { webpage: '/home', ip: '184.123.665.067' },
      { webpage: '/about/2', ip: '444.701.448.104'},
      { webpage: '/home', ip: '235.313.352.950' },
      { webpage: '/home', ip: '235.313.352.950' },
      { webpage: '/home', ip: '235.313.352.955' },
      { webpage: '/home', ip: '235.313.352.955' },
      { webpage: '/about/2', ip: '444.701.448.103' },
      { webpage: '/about/2', ip: '444.701.448.103' },
      { webpage: '/about/2', ip: '444.701.448.103' },
    ]
  end

  subject { described_class.new 'tests/test_logs.log'}

  context '#parse' do
    it 'returns correct list of logs' do
      expect(subject.parse).to eq(parse_result)
    end
  end

  context '#most_page_views' do
    let(:ordered_result) do
      [
        ['/home', 5],
        [ '/about/2', 4]
      ]
    end

    it 'ordered from most to less page views' do
      expect(subject.most_page_views(parse_result)).to eq(ordered_result)
    end
  end

  context '#most_page_views' do
    let(:ordered_result) do
      [
        ['/home', 3],
        [ '/about/2', 2]
      ]
    end

    it 'ordered from most to less page views' do
      expect(subject.uniq_page_views(parse_result)).to eq(ordered_result)
    end
  end
end
