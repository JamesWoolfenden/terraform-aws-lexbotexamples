const exportSingle = require('./export-single');
const getSingle = require('./get-single');

const exportSlot = slot => {
  if (slot.slotTypeVersion) {
    return exportSingle('slot-type', slot.slotType);
  }

  return null;
};

async function exportSlotFromIntent (intentName) {
  const intentObject = await getSingle('intent', intentName);

  await Promise.all(intentObject.slots.map(exportSlot).filter(i => i));
}

module.exports = exportSlotFromIntent;
