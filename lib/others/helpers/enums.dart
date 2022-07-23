enum DonorFormStatus{
  accepted,
  rejected,
  pending,
}

enum DonorFormStage{
  bloodClassificationAndHbLab,
  examining,
  bloodDrawing,
  diseasesDetection,
  temporaryStorage,
  finnish,
}

enum RejectionCause{
  hbDeficiency,

  //
  hIV,
  hBV,
  hCV,
  syphilis,
  //

  other
}

enum ClientStatus{
  available,
  banned,
}
