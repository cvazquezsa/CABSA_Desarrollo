
[Forma]
Clave=CorteMovTotalizadorTipoCampo
Icono=0
BarraHerramientas=S
Modulos=CORTE
MovModulo=CORTE
Nombre=Totalizadores - Tipo de Campo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=495
PosicionInicialArriba=164
PosicionInicialAlturaCliente=361
PosicionInicialAncho=376
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
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

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CorteMovTotalizadorTipoCampo
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
[Lista.ListaEnCaptura]
(Inicio)=CorteMovTotalizadorTipoCampo.Totalizador
CorteMovTotalizadorTipoCampo.Totalizador=CorteMovTotalizadorTipoCampo.Tipo
CorteMovTotalizadorTipoCampo.Tipo=(Fin)

[Lista.CorteMovTotalizadorTipoCampo.Totalizador]
Carpeta=Lista
Clave=CorteMovTotalizadorTipoCampo.Totalizador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.CorteMovTotalizadorTipoCampo.Tipo]
Carpeta=Lista
Clave=CorteMovTotalizadorTipoCampo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
Totalizador=182
Tipo=114
