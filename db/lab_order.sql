CREATE  TABLE `lab_order` (
  `lab_order_id` INT NOT NULL AUTO_INCREMENT ,
  `request_number` VARCHAR(45) NULL ,
  `barcodes` VARCHAR(255) NULL ,
  `national_id` VARCHAR(128) NULL ,
  `priority_code` VARCHAR(45) NULL ,
  `date_collected` DATETIME NULL ,
  `date_received` DATETIME NULL ,
  `patient_id` INT NULL ,
  `result` VARCHAR(255) NULL ,
  `date_result_received` DATETIME NULL ,
  `test_code` VARCHAR(255) NULL ,
  PRIMARY KEY (`lab_order_id`) ,
  UNIQUE INDEX `lab_order_id_UNIQUE` (`lab_order_id` ASC) );

