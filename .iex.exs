import_if_available(Ecto.Query)
import_if_available(BetTipper.Factory)

# Schemas
alias BetTipper.Repo
alias BetTipper.Schemas.Bet
alias BetTipper.Schemas.User

# Context
alias BetTipper.Users

# Enums
alias BetTipper.Enums.BetOutcome
alias BetTipper.Enums.BetType

# Services
alias BetTipper.Services.PlaceBetService
