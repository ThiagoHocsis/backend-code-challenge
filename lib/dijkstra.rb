class Dijkstra
  def initialize(startpoint, endpoint, weight, matrix_of_road)
    @start = startpoint
    @end = endpoint
    @weight = weight
    @path = []
    @infinit = Float::INFINITY
    vertices = number_of_vertices(matrix_of_road.dup)
    matrix_of_road =  matrix_of_road.unshift([vertices])
    read_and_init(matrix_of_road)
    dijkstra
  end

  def number_of_vertices(matrix)
    matrix = matrix.collect { |x| [x[0], x[1]] }
    matrix = matrix.zip.flatten.compact
    @nodes = matrix.uniq.dup
    matrix.uniq.count
  end

  def cost
    @r[@end] * @weight * 0.15
  end

  def shortest_path
    road(@end)
    @path
  end

  def road(node)
    road(@f[node]) if @f[node] != 0
    @path.push(node)
  end

  def dijkstra
    min = @infinit
    pos_min = @infinit

    @nodes.each do |i|
      @r[i] = @road[[@start, i]]
      @f[i] = @start if i != @start && @r[i] < @infinit
    end

    @s[@start] = 1

    @nodes[0..@nodes.size - 2].each do
      min = @infinit

      @nodes.each do |i|
        if @s[i] == 0 && @r[i] < min
          min = @r[i]
          pos_min = i
        end
      end

      @s[pos_min] = 1

      @nodes.each do|j|
        if @s[j] == 0
          if @r[j] > @r[pos_min] + @road[[pos_min, j]]
            @r[j] = @r[pos_min] + @road[[pos_min, j]]
            @f[j] = pos_min
          end
        end
      end
    end
  end

  def read_and_init(arr)
    n = arr.size - 1

    @road = Hash.new(@nodes)
    @r = Hash.new(@nodes)
    @s = Hash.new(@nodes)
    @f = Hash.new(@nodes)

    @nodes.each do |i|
      @r[i] = 0
    end

    @nodes.each do |i|
      @s[i] = 0
    end

    @nodes.each do |i|
      @f[i] = 0
    end

    @nodes.each do |i|
      @nodes.each do |j|
        if i == j
          @road[[i, j]] = 0
        else
          @road[[i, j]] = @infinit
        end
      end
    end

    (1..n).each do |i|
      x = arr[i][0]
      y = arr[i][1]
      c = arr[i][2]
      @road[[x, y]] = c
    end
  end
end