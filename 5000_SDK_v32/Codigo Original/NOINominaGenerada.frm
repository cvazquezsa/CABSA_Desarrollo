
[Forma]
Clave=NOINominaGenerada
Icono=0
CarpetaPrincipal=NOINominaGenerada
Modulos=(Todos)
Nombre=Nominas Generadas


ListaCarpetas=NOINominaGenerada
PosicionInicialAlturaCliente=385
PosicionInicialAncho=285
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=657
PosicionInicialArriba=218
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[NOINominaGenerada]
Estilo=Iconos
Clave=NOINominaGenerada
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOINominaGenerada2
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Nominas Generadas
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Del<T>
ElementosPorPaginaEsp=200
ListaEnCaptura=NOINominaGenerada2.FechaA
OtroOrden=S
ListaOrden=NOINominaGenerada2.FechaA<TAB>(Acendente)
IconosNombre=NOINominaGenerada2:NOINominaGenerada2.FechaD
[NOINominaGenerada.Columnas]
0=135

1=129
2=84
FechaA=166
FechaD=129
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Aceptar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si Precaucion( <T>¿Esta seguro de Re-Activar la Nomina del <T>+ FechaEnTexto(NOINominaGenerada2:NOINominaGenerada2.FechaD, <T>dd/mmm/aaaa<T>)+<T> - <T>+FechaEnTexto(NOINominaGenerada2:NOINominaGenerada2.FechaA, <T>dd/mmm/aaaa<T>)+<T> ?<T>,  BotonSi ,  BotonNo) = BotonSi<BR>  Entonces<BR>    ProcesarSQL(<T>spNOICancelarNomina :tEmpresa,:nEstacion,:nID, :tUsuario, :fFecha<T>, Empresa,EstacionTrabajo,NOINominaGenerada2:NOINominaGenerada2.ID,Usuario,NOINominaGenerada2:NOINominaGenerada2.FechaA)<BR>  Sino<BR>    AbortarOperacion<BR>  Fin
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[NOINominaGenerada.ListaEnCaptura]
(Inicio)=NOINominaGenerada.FechaD
NOINominaGenerada.FechaD=NOINominaGenerada.FechaA
NOINominaGenerada.FechaA=(Fin)

[NOINominaGenerada.NOINominaGenerada2.FechaA]
Carpeta=NOINominaGenerada
Clave=NOINominaGenerada2.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



EspacioPrevio=S


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)
