[Forma]
Clave=PersonalEntradaH
Nombre=<T>Asistente - Horario Entrada<T>
Icono=1
Modulos=(Todos)
PosicionInicialAlturaCliente=552
PosicionInicialAncho=772
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=254
PosicionInicialArriba=219
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista((<T>Del<T>)+FechaEnTexto(Info.Fecha, <T> dddd dd/mmm/aaaa <T>)+(<T>al<T>)+FechaEnTexto(Info.Fecha+6, <T> dddd dd/mmm/aaaa<T>), <T>Sucursal <T> + Sucursal)
Totalizadores=S
PosicionSec1=517
PosicionSeccion1=94

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalEntradaH
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todas las Sucursales)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=PersonalEntradaH.Sucursal = {Sucursal}

[Lista.PersonalEntradaH.Personal]
Carpeta=Lista
Clave=PersonalEntradaH.Personal
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.PersonalEntradaH.Domingo]
Carpeta=Lista
Clave=PersonalEntradaH.Domingo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalEntradaH.Lunes]
Carpeta=Lista
Clave=PersonalEntradaH.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalEntradaH.Martes]
Carpeta=Lista
Clave=PersonalEntradaH.Martes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalEntradaH.Miercoles]
Carpeta=Lista
Clave=PersonalEntradaH.Miercoles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalEntradaH.Jueves]
Carpeta=Lista
Clave=PersonalEntradaH.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalEntradaH.Viernes]
Carpeta=Lista
Clave=PersonalEntradaH.Viernes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalEntradaH.Sabado]
Carpeta=Lista
Clave=PersonalEntradaH.Sabado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Personal=94
NombreCompleto=302
Domingo=49
Lunes=48
Martes=47
Miercoles=48
Jueves=46
Viernes=46
Sabado=43

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar 
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S

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

[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Procesar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
ConCondicion=S
EjecucionConError=S
Expresion=ProcesarSQL(<T>spPersonalEntradaHProcesar :nSuc, :fFecha<T>, Sucursal, Info.Fecha)<BR>Forma.ActualizarForma
EjecucionCondicion=DiaNombre(Info.Fecha)=<T>Domingo<T>
EjecucionMensaje=<T>Debe Especificar un Domingo<T>

[Acciones.Fecha]
Nombre=Fecha
Boton=12
NombreEnBoton=S
NombreDesplegar=&Asignar Fecha
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Temp.Fecha, Info.Fecha)<BR>Si<BR>  Forma(<T>EspecificarFecha<T>)<BR>Entonces<BR>  Si<BR>    DiaNombre(Info.Fecha)=<T>Domingo<T><BR>  Entonces<BR>    EjecutarSQL(<T>spPersonalEntradaHSugerir :nSuc<T>, Sucursal)<BR>    Forma.ActualizarForma<BR>  Sino<BR>    Asigna(Info.Fecha, Temp.Fecha)<BR>    Error(<T>Debe Especificar un Domingo<T>)<BR>  Fin<BR>Fin

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Personas
Totalizadores2=SQL(<T>SELECT Count(*) FROM PersonalEntradaH WHERE Sucursal = :nS<T>, Sucursal)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Personas
CarpetaVisible=S

[(Carpeta Totalizadores).Personas]
Carpeta=(Carpeta Totalizadores)
Clave=Personas
Editar=S
LineaNueva=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Fecha
Fecha=Guardar
Guardar=Procesar
Procesar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PersonalEntradaH.Personal
PersonalEntradaH.Personal=NombreCompleto
NombreCompleto=PersonalEntradaH.Domingo
PersonalEntradaH.Domingo=PersonalEntradaH.Lunes
PersonalEntradaH.Lunes=PersonalEntradaH.Martes
PersonalEntradaH.Martes=PersonalEntradaH.Miercoles
PersonalEntradaH.Miercoles=PersonalEntradaH.Jueves
PersonalEntradaH.Jueves=PersonalEntradaH.Viernes
PersonalEntradaH.Viernes=PersonalEntradaH.Sabado
PersonalEntradaH.Sabado=(Fin)
