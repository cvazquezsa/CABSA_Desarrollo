[Forma]
Clave=MovFormaInfo
Nombre=Otros Datos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Lista(Info.Mov, Info.MovID)
PosicionInicialIzquierda=227
PosicionInicialArriba=153
PosicionInicialAlturaCliente=427
PosicionInicialAncho=570
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=EjecutarSQL(<T>spMovForma :tModulo, :nID, :tMov, :nSuc<T>, Info.Modulo, Info.ID, Info.Mov, Sucursal)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovForma
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=MovForma.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaFondoGris=S
FiltroGeneral=MovForma.Modulo=<T>{Info.Modulo}<T> AND MovForma.ID={Info.ID}

[Lista.MovForma.Campo]
Carpeta=Lista
Clave=MovForma.Campo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.MovForma.Valor]
Carpeta=Lista
Clave=MovForma.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Columnas]
Campo=248
Valor=293

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=MovForma.Campo
MovForma.Campo=MovForma.Valor
MovForma.Valor=(Fin)
