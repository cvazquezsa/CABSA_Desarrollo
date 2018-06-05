
[Forma]
Clave=OutputNominaG4
Icono=0
Modulos=(Todos)
Nombre=Log Errores

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=1756
PosicionInicialArriba=0
PosicionInicialAlturaCliente=528
PosicionInicialAncho=1140
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OutputNominaG4
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=OutputNominaG4.Estacion = {EstacionTrabajo}
[Lista.OutputNominaG4.Personal]
Carpeta=Lista
Clave=OutputNominaG4.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OutputNominaG4.Cuenta]
Carpeta=Lista
Clave=OutputNominaG4.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OutputNominaG4.Importe]
Carpeta=Lista
Clave=OutputNominaG4.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OutputNominaG4.Cantidad]
Carpeta=Lista
Clave=OutputNominaG4.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OutputNominaG4.Concepto]
Carpeta=Lista
Clave=OutputNominaG4.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OutputNominaG4.Movimiento]
Carpeta=Lista
Clave=OutputNominaG4.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OutputNominaG4.Fecha]
Carpeta=Lista
Clave=OutputNominaG4.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OutputNominaG4.Grupo]
Carpeta=Lista
Clave=OutputNominaG4.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.OutputNominaG4.Objeto]
Carpeta=Lista
Clave=OutputNominaG4.Objeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OutputNominaG4.OK]
Carpeta=Lista
Clave=OutputNominaG4.OK
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Personal=83
Cuenta=102
Importe=114
Cantidad=105
Concepto=187
Movimiento=91
Fecha=78
Grupo=134
Objeto=151
OK=64

[Lista.ListaEnCaptura]
(Inicio)=OutputNominaG4.Personal
OutputNominaG4.Personal=OutputNominaG4.Cuenta
OutputNominaG4.Cuenta=OutputNominaG4.Importe
OutputNominaG4.Importe=OutputNominaG4.Cantidad
OutputNominaG4.Cantidad=OutputNominaG4.Concepto
OutputNominaG4.Concepto=OutputNominaG4.Movimiento
OutputNominaG4.Movimiento=OutputNominaG4.Fecha
OutputNominaG4.Fecha=OutputNominaG4.Grupo
OutputNominaG4.Grupo=OutputNominaG4.Objeto
OutputNominaG4.Objeto=OutputNominaG4.OK
OutputNominaG4.OK=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=115
NombreEnBoton=S
NombreDesplegar=&Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



EspacioPrevio=S










[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=(Fin)
