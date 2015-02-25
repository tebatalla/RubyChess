class NoPieceAtPosition < StandardError
end

class OccupiedSpace < StandardError
end

class MoveIntoCheck < StandardError
end

class NotPlayersPiece < StandardError
end
