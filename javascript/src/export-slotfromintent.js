const { INTENT, SLOT_TYPE } = require('./config/resource.types');

const exportSingle = require('./export-single');
const getSingle = require('./get-single');

const exportSlot = ({ slotType, slotTypeVersion }) => {
  if (!slotTypeVersion) { return null; }

  return exportSingle(SLOT_TYPE, slotType);
};

async function exportSlotFromIntent (intentName) {
  const intentObject = await getSingle(INTENT, intentName);

  await Promise.all(intentObject.slots.map(exportSlot).filter(i => i));
}

module.exports = exportSlotFromIntent;
