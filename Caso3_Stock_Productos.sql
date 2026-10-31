ALTER SESSION SET CURRENT_SCHEMA = PRY2205_S2;

DEFINE TIPOCAMBIO_DOLAR = 950
DEFINE UMBRAL_BAJO = 40
DEFINE UMBRAL_ALTO = 60

SELECT
    CODPRODUCTO AS "ID",
    DESCRIPCION AS "Descripción de Producto",

    NVL(
        TO_CHAR(VALORCOMPRADOLAR),
        'Sin registro'
    ) AS "Compra en USD",
CASE
    WHEN VALORCOMPRADOLAR IS NULL THEN 'Sin registro'
    ELSE
        TO_CHAR(
            VALORCOMPRADOLAR * &TIPOCAMBIO_DOLAR,
            'FM$999G999G999',
            'NLS_NUMERIC_CHARACTERS='',.'''
        ) || ' PESOS'
END AS "USD convertido",

    TOTALSTOCK AS "Stock",

    CASE
        WHEN TOTALSTOCK IS NULL THEN 'Sin datos'
        WHEN TOTALSTOCK < &UMBRAL_BAJO THEN '¡ALERTA stock muy bajo!'
        WHEN TOTALSTOCK <= &UMBRAL_ALTO THEN '¡Reabastecer pronto!'
        ELSE 'OK'
    END AS "Alerta Stock",

    CASE
        WHEN TOTALSTOCK > 80 THEN
            TO_CHAR(
                VUNITARIO * 0.90,
                'FM$999G999G999',
                'NLS_NUMERIC_CHARACTERS='',.'''
            )
        ELSE 'N/A'
    END AS "Precio Oferta"

FROM PRODUCTO
WHERE UPPER(DESCRIPCION) LIKE '%ZAPATO%'
AND PROCEDENCIA = 'I'
ORDER BY CODPRODUCTO DESC;