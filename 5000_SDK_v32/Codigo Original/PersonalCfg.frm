[Forma]
Clave=PersonalCfg
Nombre=Deducciones Especiales
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Infonavit
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Personal, Info.Nombre)
PosicionInicialIzquierda=252
PosicionInicialArriba=171
PosicionInicialAlturaCliente=391
PosicionInicialAncho=520
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Ahorros]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ahorros
Clave=Ahorros
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
CondicionEdicion=no Usuario.BloquearPersonalCfg

[Ahorros.PersonalCfg.CajaAhorro]
Carpeta=Ahorros
Clave=PersonalCfg.CajaAhorro
Editar=S
LineaNueva=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Ahorros.PersonalCfg.CajaAhorroImporte]
Carpeta=Ahorros
Clave=PersonalCfg.CajaAhorroImporte
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ahorros.PersonalCfg.FondoAhorro]
Carpeta=Ahorros
Clave=PersonalCfg.FondoAhorro
Editar=S
LineaNueva=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Ahorros.PersonalCfg.FondoAhorroImporte]
Carpeta=Ahorros
Clave=PersonalCfg.FondoAhorroImporte
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[PA]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pensión Alimenticia
Clave=PA
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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
FiltroGeneral=PersonalCfg.Personal=<T>{Info.Personal}<T>
CondicionEdicion=no Usuario.BloquearPersonalCfg

[PA.PersonalCfg.PA1]
Carpeta=PA
Clave=PersonalCfg.PA1
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA1Base]
Carpeta=PA
Clave=PersonalCfg.PA1Base
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA1Porcentaje]
Carpeta=PA
Clave=PersonalCfg.PA1Porcentaje
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA1Acreedor]
Carpeta=PA
Clave=PersonalCfg.PA1Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.Acreedor.Nombre]
Carpeta=PA
Clave=Acreedor.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[PA.PersonalCfg.PA2]
Carpeta=PA
Clave=PersonalCfg.PA2
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA2Base]
Carpeta=PA
Clave=PersonalCfg.PA2Base
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA2Porcentaje]
Carpeta=PA
Clave=PersonalCfg.PA2Porcentaje
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA2Acreedor]
Carpeta=PA
Clave=PersonalCfg.PA2Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.Acreedor2.Nombre]
Carpeta=PA
Clave=Acreedor2.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[PA.PersonalCfg.PA3]
Carpeta=PA
Clave=PersonalCfg.PA3
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA3Base]
Carpeta=PA
Clave=PersonalCfg.PA3Base
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA3Porcentaje]
Carpeta=PA
Clave=PersonalCfg.PA3Porcentaje
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[PA.PersonalCfg.PA3Acreedor]
Carpeta=PA
Clave=PersonalCfg.PA3Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PA.Acreedor3.Nombre]
Carpeta=PA
Clave=Acreedor3.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Infonavit]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Infonavit
Clave=Infonavit
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
CondicionEdicion=no Usuario.BloquearPersonalCfg

[Infonavit.PersonalCfg.Infonavit]
Carpeta=Infonavit
Clave=PersonalCfg.Infonavit
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Infonavit.PersonalCfg.InfonavitBase]
Carpeta=Infonavit
Clave=PersonalCfg.InfonavitBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Infonavit.PersonalCfg.InfonavitPorcentaje]
Carpeta=Infonavit
Clave=PersonalCfg.InfonavitPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Infonavit.PersonalCfg.InfonavitCantidad]
Carpeta=Infonavit
Clave=PersonalCfg.InfonavitCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Forma.ListaCarpetas]
(Inicio)=Infonavit
Infonavit=Ahorros
Ahorros=PA
PA=(Fin)

[Ahorros.ListaEnCaptura]
(Inicio)=PersonalCfg.CajaAhorro
PersonalCfg.CajaAhorro=PersonalCfg.CajaAhorroImporte
PersonalCfg.CajaAhorroImporte=PersonalCfg.FondoAhorro
PersonalCfg.FondoAhorro=PersonalCfg.FondoAhorroImporte
PersonalCfg.FondoAhorroImporte=(Fin)

[PA.ListaEnCaptura]
(Inicio)=PersonalCfg.PA1
PersonalCfg.PA1=PersonalCfg.PA1Base
PersonalCfg.PA1Base=PersonalCfg.PA1Porcentaje
PersonalCfg.PA1Porcentaje=PersonalCfg.PA1Acreedor
PersonalCfg.PA1Acreedor=Acreedor.Nombre
Acreedor.Nombre=PersonalCfg.PA2
PersonalCfg.PA2=PersonalCfg.PA2Base
PersonalCfg.PA2Base=PersonalCfg.PA2Porcentaje
PersonalCfg.PA2Porcentaje=PersonalCfg.PA2Acreedor
PersonalCfg.PA2Acreedor=Acreedor2.Nombre
Acreedor2.Nombre=PersonalCfg.PA3
PersonalCfg.PA3=PersonalCfg.PA3Base
PersonalCfg.PA3Base=PersonalCfg.PA3Porcentaje
PersonalCfg.PA3Porcentaje=PersonalCfg.PA3Acreedor
PersonalCfg.PA3Acreedor=Acreedor3.Nombre
Acreedor3.Nombre=(Fin)

[Infonavit.ListaEnCaptura]
(Inicio)=PersonalCfg.Infonavit
PersonalCfg.Infonavit=PersonalCfg.InfonavitBase
PersonalCfg.InfonavitBase=PersonalCfg.InfonavitPorcentaje
PersonalCfg.InfonavitPorcentaje=PersonalCfg.InfonavitCantidad
PersonalCfg.InfonavitCantidad=(Fin)
