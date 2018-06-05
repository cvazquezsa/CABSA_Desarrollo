[Forma]
Clave=Jornada
Nombre=Jornadas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Detalle
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=396
PosicionInicialArriba=229
PosicionInicialAltura=332
PosicionInicialAncho=648
Menus=S
PosicionInicialAlturaCliente=363

MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Jornada
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
HojaMantenerSeleccion=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.Jornada.Jornada]
Carpeta=Lista
Clave=Jornada.Jornada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S
EnBarraHerramientas=S

[Lista.Columnas]
Jornada=268
HorasDiariasProm=116
Tipo=124
HorasPromedio=83
FactorAusentismo=96

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Jornada
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Detalle.Jornada.Jornada]
Carpeta=Detalle
Clave=Jornada.Jornada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Jornada.Domingo]
Carpeta=Detalle
Clave=Jornada.Domingo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
ColorFondo=Blanco
Tamano=9

[Detalle.Jornada.Lunes]
Carpeta=Detalle
Clave=Jornada.Lunes
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=9

[Detalle.Jornada.Martes]
Carpeta=Detalle
Clave=Jornada.Martes
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=9

[Detalle.Jornada.Miercoles]
Carpeta=Detalle
Clave=Jornada.Miercoles
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=9

[Detalle.Jornada.Jueves]
Carpeta=Detalle
Clave=Jornada.Jueves
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=9

[Detalle.Jornada.Viernes]
Carpeta=Detalle
Clave=Jornada.Viernes
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=9

[Detalle.Jornada.Sabado]
Carpeta=Detalle
Clave=Jornada.Sabado
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=9

[Detalle.Jornada.DescansoRompeRutina]
Carpeta=Detalle
Clave=Jornada.DescansoRompeRutina
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Jornada.DescansaFestivos]
Carpeta=Detalle
Clave=Jornada.DescansaFestivos
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=N

[Detalle.Jornada.FestivoRompeRutina]
Carpeta=Detalle
Clave=Jornada.FestivoRompeRutina
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S
EnBarraHerramientas=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S
Menu=&Archivo
EnMenu=S
EnBarraHerramientas=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Acciones.Rutina]
Nombre=Rutina
Boton=76
NombreDesplegar=&Rutina Diaria
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=JornadaD
Visible=S
NombreEnBoton=S
EspacioPrevio=S
GuardarAntes=S
ConCondicion=S
Antes=S
Menu=&Edición
EnMenu=S
ActivoCondicion=Jornada:Jornada.Tipo=<T>Control Asistencia<T>
EjecucionCondicion=ConDatos(Jornada:Jornada.Jornada)
AntesExpresiones=Asigna(Info.Jornada, Jornada:Jornada.Jornada)

[Lista.Jornada.Tipo]
Carpeta=Lista
Clave=Jornada.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Jornada.Tipo]
Carpeta=Detalle
Clave=Jornada.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
Efectos=[Negritas]

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Jornada
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
Menu=&Archivo
EnMenu=S
EspacioPrevio=S
ConCondicion=S
GuardarAntes=S
EjecucionConError=S
Expresion=Asigna(Info.FechaD,  PrimerDiaAño)<BR>Asigna(Info.FechaA,  UltimoDiaAño)<BR>Si <BR>  Forma(<T>EspecificarFechas<T>)<BR>Entonces<BR>  ProcesarSQL(<T>spGenerarJornada :tJornada, :fDe, :fA<T>, Jornada:Jornada.Jornada, Info.FechaD, Info.FechaA) <BR>Fin
ActivoCondicion=Jornada:Jornada.Tipo=<T>Control Asistencia<T>
EjecucionCondicion=ConDatos(Jornada:Jornada.Jornada) y (SQL(<T>SELECT COUNT(*) FROM JornadaD WHERE Jornada = :tJornada<T>, Jornada:Jornada.Jornada)>0)
EjecucionMensaje=<T>Falta Definir la Jornada Diaria<T>

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.VerJornada]
Nombre=VerJornada
Boton=0
Menu=&Ver
NombreDesplegar=&Jornada Laboral
EnMenu=S
Visible=S
TipoAccion=Formas
ClaveAccion=VerJornadaTiempo
ConCondicion=S
Antes=S
ActivoCondicion=Jornada:Jornada.Tipo=<T>Control Asistencia<T>
EjecucionCondicion=ConDatos(Jornada:Jornada.Jornada)
AntesExpresiones=Asigna(Info.Jornada, Jornada:Jornada.Jornada)

[Acciones.DiaFestivo]
Nombre=DiaFestivo
Boton=9
Menu=&Maestros
NombreDesplegar=Días &Festivos (Generales)
EnMenu=S
TipoAccion=Formas
ClaveAccion=DiaFestivo
Visible=S
GuardarAntes=S
Activo=S

[Acciones.EditarJornada]
Nombre=EditarJornada
Boton=0
Menu=&Edición
NombreDesplegar=&Jornada Laboral
EnMenu=S
TipoAccion=Formas
ClaveAccion=JornadaTiempo
Visible=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=F7
GuardarAntes=S
Antes=S
ActivoCondicion=Jornada:Jornada.Tipo=<T>Control Asistencia<T>
AntesExpresiones=Asigna(Info.Jornada, Jornada:Jornada.Jornada)

[Detalle.Jornada.HorasPromedio]
Carpeta=Detalle
Clave=Jornada.HorasPromedio
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
LineaNueva=S

[Lista.Jornada.HorasPromedio]
Carpeta=Lista
Clave=Jornada.HorasPromedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.JornadaDiaFestivo]
Nombre=JornadaDiaFestivo
Boton=9
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=Días Festivos Jornada
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=JornadaDiaFestivo
Visible=S
ConCondicion=S
Antes=S
GuardarAntes=S
DespuesGuardar=S
ActivoCondicion=Jornada:Jornada.Tipo=<T>Control Asistencia<T>
EjecucionCondicion=ConDatos(Jornada:Jornada.Jornada)
AntesExpresiones=Asigna(Info.Jornada, Jornada:Jornada.Jornada)

[Detalle.Jornada.FactorAusentismo]
Carpeta=Detalle
Clave=Jornada.FactorAusentismo
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Jornada.FactorAusentismo]
Carpeta=Lista
Clave=Jornada.FactorAusentismo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Jornada.JornadaReducida]
Carpeta=Detalle
Clave=Jornada.JornadaReducida
Editar=S
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Jornada.HorasSemana]
Carpeta=Detalle
Clave=Jornada.HorasSemana
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=15

[Detalle.Jornada.HorasComida]
Carpeta=Detalle
Clave=Jornada.HorasComida
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=15




[Lista.ListaEnCaptura]
(Inicio)=Jornada.Jornada
Jornada.Jornada=Jornada.Tipo
Jornada.Tipo=Jornada.HorasPromedio
Jornada.HorasPromedio=Jornada.FactorAusentismo
Jornada.FactorAusentismo=(Fin)




[Detalle.Jornada.JornadaNocturna]
Carpeta=Detalle
Clave=Jornada.JornadaNocturna
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco

Tamano=30



[Detalle.ListaEnCaptura]
(Inicio)=Jornada.Jornada
Jornada.Jornada=Jornada.Tipo
Jornada.Tipo=Jornada.HorasPromedio
Jornada.HorasPromedio=Jornada.HorasSemana
Jornada.HorasSemana=Jornada.HorasComida
Jornada.HorasComida=Jornada.FactorAusentismo
Jornada.FactorAusentismo=Jornada.Domingo
Jornada.Domingo=Jornada.Lunes
Jornada.Lunes=Jornada.Martes
Jornada.Martes=Jornada.Miercoles
Jornada.Miercoles=Jornada.Jueves
Jornada.Jueves=Jornada.Viernes
Jornada.Viernes=Jornada.Sabado
Jornada.Sabado=Jornada.DescansoRompeRutina
Jornada.DescansoRompeRutina=Jornada.DescansaFestivos
Jornada.DescansaFestivos=Jornada.FestivoRompeRutina
Jornada.FestivoRompeRutina=Jornada.JornadaReducida
Jornada.JornadaReducida=Jornada.JornadaNocturna
Jornada.JornadaNocturna=(Fin)
















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Rutina
Rutina=JornadaDiaFestivo
JornadaDiaFestivo=EditarJornada
EditarJornada=Generar
Generar=VerJornada
VerJornada=DiaFestivo
DiaFestivo=Navegador
Navegador=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
