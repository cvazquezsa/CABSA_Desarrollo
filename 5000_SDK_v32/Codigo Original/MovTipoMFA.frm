
[Forma]
Clave=MovTipoMFA
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Impuestos Póliza - Módulo Fiscal Avanzado

ListaCarpetas=MovTipoMFA
CarpetaPrincipal=MovTipoMFA
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=433
PosicionInicialArriba=208
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Modulo, Info.Mov)
ListaAcciones=GuardarCerrar
[MovTipoMFA]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=MovTipoMFA
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFA
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[MovTipoMFA.ListaEnCaptura]
(Inicio)=MovTipoMFA.TipoImpuesto
MovTipoMFA.TipoImpuesto=MovTipoMFA.Tasa
MovTipoMFA.Tasa=MovTipoMFA.CuentaTrasladable
MovTipoMFA.CuentaTrasladable=MovTipoMFA.CuentaAcreditable
MovTipoMFA.CuentaAcreditable=(Fin)

[MovTipoMFA.MovTipoMFA.TipoImpuesto]
Carpeta=MovTipoMFA
Clave=MovTipoMFA.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[MovTipoMFA.MovTipoMFA.Tasa]
Carpeta=MovTipoMFA
Clave=MovTipoMFA.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovTipoMFA.MovTipoMFA.CuentaTrasladable]
Carpeta=MovTipoMFA
Clave=MovTipoMFA.CuentaTrasladable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovTipoMFA.MovTipoMFA.CuentaAcreditable]
Carpeta=MovTipoMFA
Clave=MovTipoMFA.CuentaAcreditable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovTipoMFA.Columnas]
TipoImpuesto=94
Tasa=74
CuentaTrasladable=117
CuentaAcreditable=118

[TipoImpuesto.Columnas]
0=-2
1=88
2=248
3=-2

[Lista.Columnas]
0=207

[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
