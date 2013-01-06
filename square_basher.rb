#!/usr/bin/env ruby -w

class SquareBasher

  FIRST_SET_COUNT = 2500
  SECOND_SET_COUNT = 2499

  def solve
    min_start = 0
    max_start = 100000000

    smallest_number = find_matching_totals(min_start, max_start)

    if smallest_number != -1
      puts "Found matching totals!"
      puts "Smallest number is #{smallest_number}"
    else
      puts "Didn't find matching totals."
    end
  end

  def find_matching_totals(min_start_number, max_start_number)
    if max_start_number <= min_start_number
      return -1
    end

    puts "Checking #{min_start_number} and #{max_start_number}"

    diff_for_min_start_number = calculate_set_diffs(min_start_number)
    diff_for_max_start_number = calculate_set_diffs(max_start_number)

    if diff_for_min_start_number == 0
      return min_start_number

    elsif diff_for_max_start_number == 0
      return max_start_number

    elsif is_zero_between_numbers(diff_for_min_start_number, diff_for_max_start_number)
        middle_start_number = ((max_start_number - min_start_number) / 2) + min_start_number

        lower_half_result = find_matching_totals(min_start_number + 1, middle_start_number)
        if lower_half_result != -1
          return lower_half_result
        end

        upper_half_result = find_matching_totals(middle_start_number + 1, max_start_number - 1)
        if upper_half_result != -1
          return upper_half_result
        end

        return -1
    else
      return -1
    end
  end

  def calculate_set_diffs(start_number)
    first_set_total = calculate_squared_total(start_number, FIRST_SET_COUNT)
    second_set_total = calculate_squared_total(start_number + FIRST_SET_COUNT + 1, SECOND_SET_COUNT)

    return second_set_total - first_set_total
  end

  def calculate_squared_total(start_number, count)
    end_number = start_number + count
    total = 0

    (start_number..end_number).each { |i|
      total += i*i
    }

    return total
  end

  def is_zero_between_numbers(first_number, second_number)
    if first_number < second_number
      return first_number <= 0 && 0 <= second_number
    elsif second_number < first_number
      return second_number <= 0 && 0 <= first_number
    else
      return false
    end
  end

end

solver = SquareBasher.new
solver.solve()