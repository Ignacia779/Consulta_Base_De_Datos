ALTER SESSION SET CURRENT_SCHEMA = PRY2205_S2;

SELECT
 LPAD(REVERSE(RUTCLIENTE), 12, '*') AS "RUT",
NOMBRE AS "Cliente",
 NVL(TO_CHAR(TELEFONO), 'Sin teléfono') AS "TELEFONO",
NVL(TO_CHAR(CODCOMUNA), 'Sin comuna') AS "COMUNA",
    ESTADO,
    CASE
        WHEN (SALDO / CREDITO) * 100 < 50 THEN
            'Bueno ( ' ||
            TO_CHAR(CREDITO - SALDO, 'FM$999G999G999',
                'NLS_NUMERIC_CHARACTERS='',.''') || ')'
        WHEN (SALDO / CREDITO) * 100 <= 80 THEN
            'Regular ( ' ||
            TO_CHAR(SALDO, 'FM$999G999G999',
                'NLS_NUMERIC_CHARACTERS='',.''') || ')'
        ELSE 'Crítico'
    END AS "Estado Crédito",
    NVL(
        SUBSTR(MAIL, INSTR(MAIL, '@') + 1),
        'Correo no registrado'
    ) AS "Dominio Correo"
FROM CLIENTE
WHERE ESTADO = 'A'
AND CREDITO > 0
ORDER BY NOMBRE ASC;



