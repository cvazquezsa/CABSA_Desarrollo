
[Forma]
Clave=SAUXIndicadorD
Icono=0
Modulos=(Todos)
Nombre=Parámetros de Indicadores

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=517
PosicionInicialArriba=315
PosicionInicialAlturaCliente=201
PosicionInicialAncho=565
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Nombre, Info.Descripcion)
[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXIndicadorD
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

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=SAUXIndicadorD.Indicador = <T>{Info.Nombre}<T>
FiltroRespetar=S
FiltroTipo=General
[Hoja.SAUXIndicadorD.Parametro]
Carpeta=Hoja
Clave=SAUXIndicadorD.Parametro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Hoja.SAUXIndicadorD.IndicadorMinimo]
Carpeta=Hoja
Clave=SAUXIndicadorD.IndicadorMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.SAUXIndicadorD.Observaciones]
Carpeta=Hoja
Clave=SAUXIndicadorD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Hoja.Columnas]
Parametro=124
IndicadorMinimo=64
Observaciones=336

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Hoja.ListaEnCaptura]
(Inicio)=SAUXIndicadorD.Parametro
SAUXIndicadorD.Parametro=SAUXIndicadorD.IndicadorMinimo
SAUXIndicadorD.IndicadorMinimo=SAUXIndicadorD.Observaciones
SAUXIndicadorD.Observaciones=(Fin)
