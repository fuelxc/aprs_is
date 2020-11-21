module AprsIs
  class Filter
    module Constants
      FILTER_TYPE_MAP = {
        range: {
          prefix: 'r',
          arity: 3
        },
        prefix: {
          prefix: 'p',
          arity: -1
        },
        callsign: {
          prefix: 'b',
          arity: -1
        },
        object: {
          prefix: 'o',
          arity: -1
        },
        strict: {
          prefix: 'os',
          arity: -1
        },
        type: {
          prefix: 't',
          arity: [1,3]
        },
        symbol: {
          prefix: 's',
          arity: 3
        },
        digipeater: {
          prefix: 'd',
          arity: -1
        },
        area: {
          prefix: 'a',
          arity: 4
        },
        entry: {
          prefix: 'e',
          arity: -1
        },
        group: {
          prefix: 'g',
          arity: -1
        },
        unproto: {
          prefix: 'u',
          arity: -1
        },
        q: {
          prefix: 'q',
          arity: (1..2)
        },
        me: {
          prefix: 'm',
          arity: 1
        },
        friend: {
          prefix: 'f',
          arity: 2
        },
      }.freeze
    end
  end
end
